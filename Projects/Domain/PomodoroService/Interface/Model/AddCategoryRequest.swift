//
//  AddCategoryRequest.swift
//  PomodoroServiceInterface
//
//  Created by 김지현 on 3/17/25.
//  Copyright © 2025 PomoNyang. All rights reserved.
//

import Foundation

public struct AddCategoryRequest: Encodable {
  let title: String
  let iconType: String

  public init(
    title: String,
    iconType: String
  ) {
    self.title = title
    self.iconType = iconType
  }
}
