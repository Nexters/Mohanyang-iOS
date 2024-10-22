//
//  ButtonHuggingPriorityHorizontal.swift
//  DesignSystem
//
//  Created by devMinseok on 8/10/24.
//  Copyright © 2024 PomoNyang. All rights reserved.
//

import Foundation

public enum ButtonHuggingPriorityHorizontal {
  case high
  case medium
  case low
}

extension ButtonHuggingPriorityHorizontal {
  var width: CGFloat? {
    switch self {
    case .high:
      return nil
    case .medium:
      return Alias.Size.ButtonWidth.fixed
    case .low:
      return .infinity
    }
  }
}
