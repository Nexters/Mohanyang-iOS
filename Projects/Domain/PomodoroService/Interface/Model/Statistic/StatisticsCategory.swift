//
//  StatisticsCategory.swift
//  PomodoroService
//
//  Created by devMinseok on 7/20/25.
//  Copyright © 2025 PomoNyang. All rights reserved.
//

import Foundation

public struct StatisticsCategory: Decodable, Equatable {
  public let no: Int
  public let title: String
  public let iconType: PomodoroIconType
}
