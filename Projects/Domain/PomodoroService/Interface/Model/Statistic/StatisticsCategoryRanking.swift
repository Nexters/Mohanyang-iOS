//
//  StatisticsCategoryRanking.swift
//  PomodoroService
//
//  Created by devMinseok on 7/20/25.
//  Copyright © 2025 PomoNyang. All rights reserved.
//

import Foundation

public struct StatisticsCategoryRanking: Decodable {
  /// yyyy-mm-dd
  public let startDate: String
  /// yyyy-mm-dd
  public let endDate: String
  public let rankingItems: [StatisticsCategoryRankingItem]
}

public struct StatisticsCategoryRankingItem: Decodable {
  public let rank: Int
  public let category: StatisticsCategory
  /// PT30M
  public let totalFocusTime: String
}
