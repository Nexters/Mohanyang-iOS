//
//  CategoryNameError.swift
//  HomeFeature
//
//  Created by 김지현 on 2/27/25.
//  Copyright © 2025 PomoNyang. All rights reserved.
//

import Foundation
import DesignSystem

enum CategoryNameError: Equatable {
  case cantSetExistName
  case exceedsMaxLength(Int)
}

extension CategoryNameError: InputFieldErrorProtocol {
  var message: String {
    switch self {
    case .cantSetExistName:
      "이미 존재하는 카테고리예요."
    case .exceedsMaxLength(let max):
      "최대 \(max)글자까지 입력할 수 있어요."
    }
  }
}
