//
//  BoxButtonStyle.swift
//  DesignSystem
//
//  Created by devMinseok on 8/5/24.
//  Copyright © 2024 PomoNyang. All rights reserved.
//

import SwiftUI

public struct BoxButtonStyle: ButtonStyle {
  @Environment(\.isEnabled) var isEnabled
  let size: BoxButtonStyleSize
  let level: BoxButtonStyleLevel
  let width: ButtonHuggingPriorityHorizontal
  
  public init(
    size: BoxButtonStyleSize,
    level: BoxButtonStyleLevel,
    width: ButtonHuggingPriorityHorizontal
  ) {
    self.size = size
    self.level = level
    self.width = width
  }
  
  public func makeBody(configuration: Configuration) -> some View {
    configuration.label
      .frame(height: size.buttonHeight)
      .frame(maxWidth: width.width)
      .font(size.font)
      .padding(.horizontal, size.horizontalSideSpacing)
      .background(
        getBackgroundColor(isPressed: configuration.isPressed),
        in: RoundedRectangle(cornerRadius: size.radius)
      )
      .foregroundStyle(
        getForegroundColor(isPressed: configuration.isPressed)
      )
      .labelStyle(DefaultBarButtonLabelStyle())
      .barButtonDetailStyle(DefaultBarButtonDetailStyle())
  }
  
  private func getBackgroundColor(isPressed: Bool) -> Color {
    if isEnabled {
      if isPressed {
        return level.pressedBackground
      } else {
        return level.defaultBackground
      }
    } else {
      return level.disabledBackground
    }
  }
  
  private func getForegroundColor(isPressed: Bool) -> Color {
    if isEnabled {
      if isPressed {
        return level.pressedForeground
      } else {
        return level.defaultForeground
      }
    } else {
      return level.disabledForeground
    }
  }
}

extension ButtonStyle where Self == BoxButtonStyle {
  public static func box(
    level: BoxButtonStyleLevel,
    size: BoxButtonStyleSize,
    width: ButtonHuggingPriorityHorizontal = .high
  ) -> Self {
    return BoxButtonStyle(size: size, level: level, width: width)
  }
}
