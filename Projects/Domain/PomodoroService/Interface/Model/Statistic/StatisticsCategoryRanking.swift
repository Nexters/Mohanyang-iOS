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

extension StatisticsCategoryRankingItem {
  public func getTotalFocusTimeText(units: NSCalendar.Unit) -> String {
    guard let dateComponents = DateComponents.durationFrom8601String(totalFocusTime) else { return "" }
    let formatter = DateComponentsFormatter()
    formatter.unitsStyle = .full
    formatter.allowedUnits = units
    return formatter.string(from: dateComponents) ?? ""
  }
}
