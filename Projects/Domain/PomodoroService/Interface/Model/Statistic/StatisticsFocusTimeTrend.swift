//
//  StatisticsFocusTimeTrend.swift
//  PomodoroService
//
//  Created by devMinseok on 7/20/25.
//  Copyright © 2025 PomoNyang. All rights reserved.
//

import Foundation

public struct StatisticsFocusTimeTrend: Decodable {
  /// yyyy-mm-dd
  public let startDate: String
  /// yyyy-mm-dd
  public let endDate: String
  public let dateToFocusTimeStatistics: [StatisticsFocusTimeTrendItem]
}

public struct StatisticsFocusTimeTrendItem: Decodable {
  /// yyyy-mm-dd
  public let date: String
  /// PT30M
  public let totalFocusTime: String
}
