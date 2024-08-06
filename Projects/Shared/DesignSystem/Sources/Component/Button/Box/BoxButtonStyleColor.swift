//
//  BoxButtonStyleColor.swift
//  DesignSystem
//
//  Created by devMinseok on 8/7/24.
//  Copyright © 2024 PomoNyang. All rights reserved.
//

import SwiftUI

public enum BoxButtonStyleColor {
  case primary
  case secondary
  case tertiary
}

extension BoxButtonStyleColor {
  var defaultBackground: Color {
    switch self {
    case .primary:
      return Alias.Color.Background.accent1
    case .secondary:
      return Alias.Color.Background.inverse
    case .tertiary:
      return Alias.Color.Background.secondary
    }
  }
  var disabledBackground: Color {
    return Alias.Color.Background.secondary
  }
  var pressedBackground: Color {
    return defaultBackground.opacity(0.9)
  }
  
  var defaultForeground: Color {
    switch self {
    case .primary:
      Alias.Color.Text.inverse
    case .secondary:
      Alias.Color.Text.inverse
    case .tertiary:
      Alias.Color.Text.tertiary
    }
  }
  var disabledForeground: Color {
    Alias.Color.Text.disabled
  }
  var pressedForeground: Color {
    return defaultForeground.opacity(0.9)
  }
}
