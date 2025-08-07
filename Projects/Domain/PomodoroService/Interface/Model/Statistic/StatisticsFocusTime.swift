//
//  StatisticsFocusTime.swift
//  PomodoroService
//
//  Created by devMinseok on 7/20/25.
//  Copyright © 2025 PomoNyang. All rights reserved.
//

import Foundation

public struct StatisticsFocusTime: Decodable, Equatable, Identifiable {
  public let no: Int
  public let category: StatisticsCategory?
  /// PT30M
  public let totalFocusTime: String
  public let startedAt: Date
  public let doneAt: Date

  public var id: Int {
    return no
  }
}

extension StatisticsFocusTime {
  public func getTotalFocusTimeText(units: NSCalendar.Unit) -> String {
    guard let dateComponents = DateComponents.durationFrom8601String(totalFocusTime) else { return "" }
    let formatter = DateComponentsFormatter()
    formatter.unitsStyle = .full
    formatter.allowedUnits = units
    return formatter.string(from: dateComponents) ?? ""
  }
}


extension String {
  public func iso8601DurationToText(units: NSCalendar.Unit) -> String {
    guard let dateComponents = DateComponents.durationFrom8601String(totalFocusTime) else { return "" }
    let formatter = DateComponentsFormatter()
    formatter.unitsStyle = .full
    formatter.allowedUnits = units
    return formatter.string(from: dateComponents) ?? ""
  }
}
