//
//  BoxButtonStyleSize.swift
//  DesignSystem
//
//  Created by devMinseok on 8/7/24.
//  Copyright © 2024 PomoNyang. All rights reserved.
//

import SwiftUI

public enum BoxButtonStyleSize {
  case large
  case medium
  case small
}

extension BoxButtonStyleSize {
  var radius: CGFloat {
    switch self {
    case .large:
      return Alias.BorderRadius.small
    case .medium:
      return Alias.BorderRadius.small
    case .small:
      return Alias.BorderRadius.xSmall
    }
  }
  
  var font: Font {
    switch self {
    case .large:
      Typography.header5
    case .medium:
      Typography.bodySB
    case .small:
      Typography.subBodySB
    }
  }
  
  var buttonHeight: CGFloat {
    switch self {
    case .large:
      return Alias.Size.ButtonHeight.large
    case .medium:
      return Alias.Size.ButtonHeight.medium
    case .small:
      return Alias.Size.ButtonHeight.small
    }
  }
  
  var horizontalSideSpacing: CGFloat {
    switch self {
    case .large:
      return Alias.Spacing.xLarge
    case .medium:
      return Alias.Spacing.large
    case .small:
      return Alias.Spacing.medium
    }
  }
}
