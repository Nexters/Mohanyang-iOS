//
//  StatisticsFocusTimeTrend.swift
//  PomodoroService
//
//  Created by devMinseok on 7/20/25.
//  Copyright © 2025 PomoNyang. All rights reserved.
//

import Foundation

import Utils

public struct StatisticsFocusTimeTrend: Decodable, Equatable {
  /// yyyy-mm-dd
  public let startDate: Date
  /// yyyy-mm-dd
  public let endDate: Date
  public let dateToFocusTimeStatistics: [StatisticsFocusTimeTrendItem]

  /// PT30M
  public var totalFocusTime: String {
    var allTotalMinutes: Int = 0
    dateToFocusTimeStatistics.forEach { time in
      let totalMinutes = DateComponents.durationFrom8601String(time.totalFocusTime)?.totalMinutes ?? 0
      allTotalMinutes += totalMinutes
    }
    return DateComponents(minute: allTotalMinutes).to8601DurationString() ?? "PT0S"
  }
}

public struct StatisticsFocusTimeTrendItem: Decodable, Equatable {
  /// yyyy-mm-dd
  public let date: Date
  /// PT30M
  public let totalFocusTime: String
}
