//
//  CategoryNameError.swift
//  HomeFeature
//
//  Created by 김지현 on 2/27/25.
//  Copyright © 2025 PomoNyang. All rights reserved.
//

import Foundation
import DesignSystem

enum CategoryNameError {
  case cantSetExistName
}

extension CategoryNameError: InputFieldErrorProtocol {
  var message: String {
    switch self {
    case .cantSetExistName:
      "이미 존재하는 카테고리예요."
    }
  }
}
