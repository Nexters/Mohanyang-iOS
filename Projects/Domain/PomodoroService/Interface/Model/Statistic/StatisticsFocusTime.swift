//
//  StatisticsFocusTime.swift
//  PomodoroService
//
//  Created by devMinseok on 7/20/25.
//  Copyright © 2025 PomoNyang. All rights reserved.
//

import Foundation

public struct StatisticsFocusTime: Decodable {
  public let no: Int
  public let category: StatisticsCategory?
  /// PT30M
  public let totalFocusTime: String
  public let startedAt: Date
  public let doneAt: Date
}
