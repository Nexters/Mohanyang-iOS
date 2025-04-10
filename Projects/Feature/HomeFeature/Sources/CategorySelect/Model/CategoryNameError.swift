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
  case cantSetExistName(String)
  case exceedsMaxLength(Int)
}

extension CategoryNameError: InputFieldErrorProtocol {
  var message: String {
    switch self {
    case .cantSetExistName(let msg):
      return msg
    case .exceedsMaxLength(let max):
      return "최대 \(max)글자까지 입력할 수 있어요."
    }
  }
}
