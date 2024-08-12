//
//  TextButtonStyle.swift
//  DesignSystem
//
//  Created by devMinseok on 8/7/24.
//  Copyright © 2024 PomoNyang. All rights reserved.
//

import SwiftUI

public struct TextButtonStyle: ButtonStyle {
  @Environment(\.isEnabled) var isEnabled
  let size: TextButtonStyleSize
  let level: TextButtonStyleLevel
  
  public init(
    size: TextButtonStyleSize,
    level: TextButtonStyleLevel
  ) {
    self.size = size
    self.level = level
  }
  
  public func makeBody(configuration: Configuration) -> some View {
    configuration.label
      .frame(height: size.buttonHeight)
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

extension ButtonStyle where Self == TextButtonStyle {
  public static func text(
    level: TextButtonStyleLevel,
    size: TextButtonStyleSize
  ) -> Self {
    return TextButtonStyle(size: size, level: level)
  }
}
