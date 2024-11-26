//
//  PomodoroActivityAttributes.swift
//  PomodoroServiceInterface
//
//  Created by devMinseok on 11/24/24.
//  Copyright © 2024 PomoNyang. All rights reserved.
//

import Foundation
import ActivityKit

public struct PomodoroActivityAttributes: Equatable, ActivityAttributes {
  public struct ContentState: Codable, Hashable {
    public var category: PomodoroCategory
    public var goalDatetime: Date
    public var isRest: Bool
    
    public var dateRange: ClosedRange<Date> {
      return Date.now...goalDatetime
    }
    
    public init(
      category: PomodoroCategory,
      goalDatetime: Date,
      isRest: Bool
    ) {
      self.category = category
      self.goalDatetime = goalDatetime
      self.isRest = isRest
    }
  }
  
  public init() {}
}
