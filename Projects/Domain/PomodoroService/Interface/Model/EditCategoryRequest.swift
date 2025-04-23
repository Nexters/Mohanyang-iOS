//
//  EditCategoryRequest.swift
//  PomodoroServiceInterface
//
//  Created by 김지현 on 4/10/25.
//  Copyright © 2025 PomoNyang. All rights reserved.
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
