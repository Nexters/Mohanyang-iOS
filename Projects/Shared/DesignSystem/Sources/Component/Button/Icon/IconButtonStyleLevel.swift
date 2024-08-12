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
}

extension IconButtonStyleLevel {
  var defaultBackground: Color {
    return Alias.Color.Background.accent1
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
    }
  }
}
