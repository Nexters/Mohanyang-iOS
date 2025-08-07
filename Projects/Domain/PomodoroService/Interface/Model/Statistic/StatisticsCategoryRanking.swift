//
//  StatisticsCategoryRanking.swift
//  PomodoroService
//
//  Created by devMinseok on 7/20/25.
//  Copyright © 2025 PomoNyang. All rights reserved.
//

import Foundation

public struct StatisticsCategoryRanking: Decodable, Equatable {
  /// yyyy-mm-dd
  public let startDate: Date
  /// yyyy-mm-dd
  public let endDate: Date
  public let rankingItems: [StatisticsCategoryRankingItem]
}

public struct StatisticsCategoryRankingItem: Decodable, Equatable {
  public let rank: Int
  public let category: StatisticsCategory
  /// PT30M
  public let totalFocusTime: String
}
