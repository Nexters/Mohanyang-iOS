//
//  IconButtonStyleLevel.swift
//  DesignSystem
//
//  Created by devMinseok on 8/12/24.
//  Copyright © 2024 PomoNyang. All rights reserved.
//

import SwiftUI

public enum IconButtonStyleLevel {
  case primary
  case secondary
}

extension IconButtonStyleLevel {
  var defaultBackground: Color {
    switch self {
    case .primary:
      return Alias.Color.Background.accent1
    case .secondary:
      return Alias.Color.Background.secondary
    }
  }
  
  var disabledBackground: Color {
    return Alias.Color.Icon.disabled
  }
  
  var pressedBackground: Color {
    return defaultBackground.opacity(0.9)
  }
  
  var defaultForeground: Color {
    switch self {
    case .primary:
      return Global.Color.white
    case .secondary:
      return Alias.Color.Icon.secondary
    }
  }
}
