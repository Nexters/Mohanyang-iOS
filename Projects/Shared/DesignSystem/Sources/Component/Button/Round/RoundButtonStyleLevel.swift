//
//  RoundButtonStyleLevel.swift
//  DesignSystem
//
//  Created by devMinseok on 8/12/24.
//  Copyright © 2024 PomoNyang. All rights reserved.
//

import SwiftUI

public enum RoundButtonStyleLevel {
  case primary
  case secondary
}

extension RoundButtonStyleLevel {
  var defaultBackground: Color {
    switch self {
    case .primary:
      return Alias.Color.Background.accent1
    case .secondary:
      return Alias.Color.Background.inverse
    }
  }
  
  var pressedBackground: Color {
    return defaultBackground.opacity(0.9)
  }
}
