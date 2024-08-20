//
//  FocusTimeSummary.swift
//  PomodoroServiceInterface
//
//  Created by devMinseok on 8/20/24.
//  Copyright © 2024 PomoNyang. All rights reserved.
//

import Foundation

public struct FocusTimeSummary: Decodable, Equatable {
  public let totalFocusTime: String
  public let categories: [PomodoroCategory]
  public let todayFocusTime: String
  public let weekFocusTime: String
}
