//
//  IconButtonStyle.swift
//  DesignSystem
//
//  Created by devMinseok on 8/12/24.
//  Copyright © 2024 PomoNyang. All rights reserved.
//

import SwiftUI

public struct IconButtonStyle: ButtonStyle {
  @Environment(\.isEnabled) var isEnabled
  let isFilled: Bool
  let level: IconButtonStyleLevel
  
  public init(
    isFilled: Bool,
    level: IconButtonStyleLevel
  ) {
    self.isFilled = isFilled
    self.level = level
  }
  
  public func makeBody(configuration: Configuration) -> some View {
    configuration.label
      .padding(Alias.Spacing.small)
      .background(
        getBackgroundColor(isFilled: isFilled, isPressed: configuration.isPressed),
        in: RoundedRectangle(cornerRadius: Alias.BorderRadius.small)
      )
      .foregroundColor(
        getForegroundColor(isFilled: isFilled)
      )
      .labelStyle(SingleIconButtonLabelStyle())
      .singleIconButtonDetailStyle(DefaultSingleIconButtonDetailStyle())
      .opacity(isEnabled ? 1 : 0.6)
  }
  
  private func getBackgroundColor(isFilled: Bool, isPressed: Bool) -> Color {
    if isEnabled {
      if isPressed {
        return isFilled ? level.pressedBackground : Global.Color.black.opacity(Alias.Interaction.pressed)
      } else {
        return isFilled ? level.defaultBackground : .clear
      }
    } else {
      return isFilled ? level.disabledBackground : .clear
    }
  }
  
  private func getForegroundColor(isFilled: Bool) -> Color? {
    if isFilled {
      return level.defaultForeground
    } else {
      return nil
    }
  }
}

extension ButtonStyle where Self == IconButtonStyle {
  public static func icon(
    isFilled: Bool,
    level: IconButtonStyleLevel
  ) -> Self {
    return IconButtonStyle(isFilled: isFilled, level: level)
  }
}
