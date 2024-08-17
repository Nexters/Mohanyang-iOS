//
//  EditCategoryRequest.swift
//  PomodoroService
//
//  Created by devMinseok on 8/17/24.
//  Copyright © 2024 PomoNyang. All rights reserved.
//

import Foundation

public struct EditCategoryRequest: Encodable {
  let focusTime: String
  let restTime: String
  
  public init(
    focusTime: String,
    restTime: String
  ) {
    self.focusTime = focusTime
    self.restTime = restTime
  }
}
