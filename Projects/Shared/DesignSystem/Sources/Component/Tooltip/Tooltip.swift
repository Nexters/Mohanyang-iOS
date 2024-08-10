//
//  Tooltip.swift
//  DesignSystem
//
//  Created by devMinseok on 8/9/24.
//  Copyright © 2024 PomoNyang. All rights reserved.
//

import SwiftUI

public protocol Tooltip: Hashable {
  var title: Text { get }
  var color: TooltipColor { get }
  var direction: TooltipDirection { get }
  var dimEnabled: Bool { get }
  var targetCornerRadius: CGFloat? { get }
  var padding: CGFloat { get }
}

public enum TooltipDirection {
  case up
  case down
}

public enum TooltipColor {
  case white
  case black
  
  var foregroundColor: Color {
    switch self {
    case .white:
      return Alias.Color.Text.secondary
    case .black:
      return Alias.Color.Text.inverse
    }
  }
  
  var backgroundColor: Color {
    switch self {
    case .white:
      return Global.Color.white
    case .black:
      return Alias.Color.Background.inverse
    }
  }
}
