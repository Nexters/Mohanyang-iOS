//
//  NamingCatError.swift
//  OnboardingFeature
//
//  Created by 김지현 on 8/17/24.
//  Copyright © 2024 PomoNyang. All rights reserved.
//

import Foundation
import DesignSystem

enum NamingCatError {
  case hasSpecialCharacter
  case exceedsMaxLength
  case startsWithWhiteSpace
}

extension NamingCatError: InputFieldErrorProtocol {
  var message: String {
    switch self {
    case .hasSpecialCharacter:
      "고양이 이름에는 공백, 특수문자가 들어갈 수 없어요"
    case .exceedsMaxLength:
      "고양이 이름은 10글자를 넘길 수 없어요"
    case .startsWithWhiteSpace:
      "고양이 이름은 빈 칸이 될 수 없어요"
    }
  }
}
