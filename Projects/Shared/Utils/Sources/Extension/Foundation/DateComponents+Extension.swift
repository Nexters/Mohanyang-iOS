//
//  DateComponents+Extension.swift
//  Utils
//
//  Created by devMinseok on 8/17/24.
//  Copyright © 2024 PomoNyang. All rights reserved.
//

import Foundation

extension DateComponents {
  public var totalSeconds: Int {
    let secondsFromMinutes = (self.minute ?? 0) * 60
    let secondsFromHours = (self.hour ?? 0) * 3600
    let secondsFromDays = (self.day ?? 0) * 86400
    let secondsFromWeeks = (self.weekOfYear ?? 0) * 604800
    let secondsFromMonths = (self.month ?? 0) * 2629800 // 평균 월 길이 (30.44일)
    let secondsFromYears = (self.year ?? 0) * 31557600 // 평균 년 길이 (365.25일)
    return (self.second ?? 0) + secondsFromMinutes + secondsFromHours + secondsFromDays + secondsFromWeeks + secondsFromMonths + secondsFromYears
  }
  
  public var totalMinutes: Int {
    let minutesFromSeconds = (self.second ?? 0) / 60
    let minutesFromHours = (self.hour ?? 0) * 60
    let minutesFromDays = (self.day ?? 0) * 1440
    let minutesFromWeeks = (self.weekOfYear ?? 0) * 10080
    let minutesFromMonths = (self.month ?? 0) * 43830 // 평균 월 길이 (30.44일)
    let minutesFromYears = (self.year ?? 0) * 525960 // 평균 년 길이 (365.25일)
    return (self.minute ?? 0) + minutesFromSeconds + minutesFromHours + minutesFromDays + minutesFromWeeks + minutesFromMonths + minutesFromYears
  }
  
  public var totalHours: Int {
    let hoursFromMinutes = (self.minute ?? 0) / 60
    let hoursFromDays = (self.day ?? 0) * 24
    let hoursFromWeeks = (self.weekOfYear ?? 0) * 168
    let hoursFromMonths = (self.month ?? 0) * 730 // 평균 월 길이 (30.44일)
    let hoursFromYears = (self.year ?? 0) * 8766 // 평균 년 길이 (365.25일)
    return (self.hour ?? 0) + hoursFromMinutes + hoursFromDays + hoursFromWeeks + hoursFromMonths + hoursFromYears
  }
  
  public var totalDays: Int {
    let daysFromHours = (self.hour ?? 0) / 24
    let daysFromWeeks = (self.weekOfYear ?? 0) * 7
    let daysFromMonths = (self.month ?? 0) * 30 // 평균 월 길이 (30일)
    let daysFromYears = (self.year ?? 0) * 365 // 평균 년 길이 (365일)
    return (self.day ?? 0) + daysFromHours + daysFromWeeks + daysFromMonths + daysFromYears
  }
  
  public var totalWeeks: Int {
    let weeksFromDays = (self.day ?? 0) / 7
    let weeksFromMonths = (self.month ?? 0) * 4 // 평균 월 길이 (4주)
    let weeksFromYears = (self.year ?? 0) * 52 // 평균 년 길이 (52주)
    return (self.weekOfYear ?? 0) + weeksFromDays + weeksFromMonths + weeksFromYears
  }
  
  public var totalMonths: Int {
    let monthsFromDays = (self.day ?? 0) / 30 // 평균 일 길이 (30일)
    let monthsFromWeeks = (self.weekOfYear ?? 0) / 4 // 평균 주 길이 (4주)
    let monthsFromYears = (self.year ?? 0) * 12
    return (self.month ?? 0) + monthsFromDays + monthsFromWeeks + monthsFromYears
  }
  
  public var totalYears: Int {
    let yearsFromDays = (self.day ?? 0) / 365 // 평균 일 길이 (365일)
    let yearsFromWeeks = (self.weekOfYear ?? 0) / 52 // 평균 주 길이 (52주)
    let yearsFromMonths = (self.month ?? 0) / 12
    return (self.year ?? 0) + yearsFromDays + yearsFromWeeks + yearsFromMonths
  }
}
