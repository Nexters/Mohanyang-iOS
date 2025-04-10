//
//  EditCategoryRequest.swift
//  PomodoroService
//
//  Created by devMinseok on 8/17/24.
//  Copyright © 2024 PomoNyang. All rights reserved.
//

import Foundation

public struct EditCategoryRequest: Encodable {
  let title: String?
  let iconType: String?
  let focusTime: String?
  let restTime: String?
  
  public init(
    title: String? = nil,
    iconType: String? = nil,
    focusTime: String? = nil,
    restTime: String? = nil
  ) {
    self.title = title
    self.iconType = iconType
    self.focusTime = focusTime
    self.restTime = restTime
  }
}
