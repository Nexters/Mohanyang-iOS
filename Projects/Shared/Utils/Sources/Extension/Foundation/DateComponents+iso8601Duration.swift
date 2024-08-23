//
//  DateComponents+iso8601Duration.swift
//  Utils
//
//  Created by devMinseok on 8/23/24.
//  Copyright © 2024 PomoNyang. All rights reserved.
//

import Foundation

/*
 * https://github.com/leonx98/Swift-ISO8601-DurationParser
 * This extension converts ISO 8601 duration strings with the format: P[n]Y[n]M[n]DT[n]H[n]M[n]S or P[n]W into date components
 * Examples:
 * PT12H = 12 hours
 * P3D = 3 days
 * P3DT12H = 3 days, 12 hours
 * P3Y6M4DT12H30M5S = 3 years, 6 months, 4 days, 12 hours, 30 minutes and 5 seconds
 * P10W = 70 days
 * For more information look here: http://en.wikipedia.org/wiki/ISO_8601#Durations
 */
extension DateComponents {
  /// ISO8601 Duration -> DateComponents 
  public static func durationFrom8601String(_ durationString: String) -> DateComponents? {
    try? Self.from8601String(durationString)
  }
  
  // Note: Does not handle fractional values for months
  // Format: PnYnMnDTnHnMnS or PnW
  static func from8601String(_ durationString: String) throws -> DateComponents {
    guard durationString.starts(with: "P") else {
      throw DurationParsingError.invalidFormat(durationString)
    }
    
    let durationString = String(durationString.dropFirst())
    var dateComponents = DateComponents()
    
    if let week = componentFor("W", in: durationString) {
      // 7 day week specified in ISO 8601 standard
      dateComponents.day = Int(week * 7.0)
      return dateComponents
    }
    
    let tRange = (durationString as NSString).range(of: "T", options: .literal)
    let periodString: String
    let timeString: String
    if tRange.location == NSNotFound {
      periodString = durationString
      timeString = ""
    } else {
      periodString = (durationString as NSString).substring(to: tRange.location)
      timeString = (durationString as NSString).substring(from: tRange.location + 1)
    }
    
    // DnMnYn
    let year = componentFor("Y", in: periodString)
    let month = componentFor("M", in: periodString).addingFractionsFrom(year, multiplier: 12)
    let day = componentFor("D", in: periodString)
    
    if let monthFraction = month?.truncatingRemainder(dividingBy: 1),
       monthFraction != 0 {
      // Representing fractional months isn't supported by DateComponents, so we don't allow it here
      throw DurationParsingError.unsupportedFractionsForMonth(durationString)
    }
    
    dateComponents.year = year?.nonFractionParts
    dateComponents.month = month?.nonFractionParts
    dateComponents.day = day?.nonFractionParts
    
    // SnMnHn
    let hour = componentFor("H", in: timeString).addingFractionsFrom(day, multiplier: 24)
    let minute = componentFor("M", in: timeString).addingFractionsFrom(hour, multiplier: 60)
    let second = componentFor("S", in: timeString).addingFractionsFrom(minute, multiplier: 60)
    dateComponents.hour = hour?.nonFractionParts
    dateComponents.minute = minute?.nonFractionParts
    dateComponents.second = second.map { Int($0.rounded()) }
    
    return dateComponents
  }
  
  private static func componentFor(_ designator: String, in string: String) -> Double? {
    // First split by the designator we're interested in, and then split by all separators. This should give us whatever's before our designator, but after the previous one.
    let beforeDesignator = string.components(separatedBy: designator).first?.components(separatedBy: .separators).last
    return beforeDesignator.flatMap { Double($0) }
  }
  
  enum DurationParsingError: Error {
    case invalidFormat(String)
    case unsupportedFractionsForMonth(String)
  }
}

extension Optional where Wrapped == Double {
  func addingFractionsFrom(_ other: Double?, multiplier: Double) -> Self {
    guard let other = other else { return self }
    let toAdd = other.truncatingRemainder(dividingBy: 1) * multiplier
    guard let self = self else { return toAdd }
    return self + toAdd
  }
}

extension Double {
  var nonFractionParts: Int {
    Int(floor(self))
  }
}

extension CharacterSet {
  static let separators = CharacterSet(charactersIn: "PWTYMDHMS")
}

extension DateComponents.DurationParsingError: LocalizedError {
  public var errorDescription: String? {
    switch self {
    case .invalidFormat(let durationString):
      return "\(durationString) has an invalid format, The durationString must have a format of PnYnMnDTnHnMnS or PnW"
    case .unsupportedFractionsForMonth(let durationString):
      return "\(durationString) has an invalid format, fractions aren't supported for the month-position"
    }
  }
}

extension DateComponents {
  /// DateComponents -> ISO8601 Duration
  public func to8601DurationString() -> String {
    var durationString = "P"
    
    // 년, 월, 주, 일, 시간, 분, 초를 고려하여 변환
    let totalSeconds = (self.second ?? 0)
    + (self.minute ?? 0) * 60
    + (self.hour ?? 0) * 3600
    + (self.day ?? 0) * 86400
    + (self.weekOfYear ?? 0) * 604800
    + (self.month ?? 0) * 2629800 // 평균 월 길이 (30.44일)
    + (self.year ?? 0) * 31557600 // 평균 년 길이 (365.25일)
    
    if totalSeconds == 0 {
      return ""
    }
    
    var remainingSeconds = totalSeconds
    
    let years = remainingSeconds / 31557600
    remainingSeconds %= 31557600
    let months = remainingSeconds / 2629800
    remainingSeconds %= 2629800
    let weeks = remainingSeconds / 604800
    remainingSeconds %= 604800
    let days = remainingSeconds / 86400
    remainingSeconds %= 86400
    let hours = remainingSeconds / 3600
    remainingSeconds %= 3600
    let minutes = remainingSeconds / 60
    remainingSeconds %= 60
    let seconds = remainingSeconds
    
    if years > 0 {
      durationString += "\(years)Y"
    }
    
    if months > 0 {
      durationString += "\(months)M"
    }
    
    if weeks > 0 {
      durationString += "\(weeks)W"
    } else if days > 0 {
      durationString += "\(days)D"
    }
    
    if hours > 0 || minutes > 0 || seconds > 0 {
      durationString += "T"
      if hours > 0 {
        durationString += "\(hours)H"
      }
      if minutes > 0 {
        durationString += "\(minutes)M"
      }
      if seconds > 0 {
        durationString += "\(seconds)S"
      }
    }
    
    return durationString
  }
}
