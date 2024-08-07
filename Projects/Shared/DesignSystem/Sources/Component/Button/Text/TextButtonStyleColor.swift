//
//  TextButtonStyleColor.swift
//  DesignSystem
//
//  Created by devMinseok on 8/7/24.
//  Copyright © 2024 PomoNyang. All rights reserved.
//

import SwiftUI

public enum TextButtonStyleColor {
  case primary
  case secondary
}

extension TextButtonStyleColor {
  var defaultBackground: Color {
    return .clear
  }
  var disabledBackground: Color {
    return .clear
  }
  var pressedBackground: Color {
    return Global.Color.black.opacity(Alias.Interaction.pressed)
  }
  
  var defaultForeground: Color {
    switch self {
    case .primary:
      Alias.Color.Text.secondary
    case .secondary:
      Alias.Color.Text.tertiary
    }
  }
  var disabledForeground: Color {
    switch self {
    case .primary:
      Alias.Color.Text.secondary
    case .secondary:
      Alias.Color.Text.tertiary
    }
  }
  var pressedForeground: Color {
    return Alias.Color.Text.secondary
  }
}
