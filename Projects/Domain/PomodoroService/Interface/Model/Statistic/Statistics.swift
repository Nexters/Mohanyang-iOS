//
//  Statistics.swift
//  PomodoroService
//
//  Created by devMinseok on 7/20/25.
//  Copyright © 2025 PomoNyang. All rights reserved.
//

import Foundation

public struct Statistics: Decodable {
  public let date: String
  /// PT30M
  public let totalFocusTime: String
  public let focusTimes: [StatisticsFocusTime]
  public let weeklyFocusTimeTrend: StatisticsFocusTimeTrend
  public let categoryRanking: StatisticsCategoryRankingItem
}
