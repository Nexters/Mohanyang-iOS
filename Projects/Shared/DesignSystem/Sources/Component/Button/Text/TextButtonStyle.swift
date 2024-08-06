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
  let color: TextButtonStyleColor
  
  public init(
    size: TextButtonStyleSize,
    color: TextButtonStyleColor
  ) {
    self.size = size
    self.color = color
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
      .foregroundColor(
        getForegroundColor(isPressed: configuration.isPressed)
      )
      .labelStyle(TextButtonLabelStyle())
      .detailStyle(TextButtonDetailStyle())
  }
  
  private func getBackgroundColor(isPressed: Bool) -> Color {
    if isEnabled {
      if isPressed {
        return color.pressedBackground
      } else {
        return color.defaultBackground
      }
    } else {
      return color.disabledBackground
    }
  }
  
  private func getForegroundColor(isPressed: Bool) -> Color {
    if isEnabled {
      if isPressed {
        return color.pressedForeground
      } else {
        return color.defaultForeground
      }
    } else {
      return color.disabledForeground
    }
  }
}

extension ButtonStyle where Self == TextButtonStyle {
  public static func text(
    size: TextButtonStyleSize,
    color: TextButtonStyleColor
  ) -> Self {
    return TextButtonStyle(size: size, color: color)
  }
}

struct TextButtonDetailStyle: DetailStyle {
  func makeBody(configuration: Configuration) -> some View {
    HStack(spacing: Alias.Spacing.small) {
      configuration.leftIcon
      configuration.title
      configuration.rightIcon
    }
  }
}

struct TextButtonLabelStyle: LabelStyle {
  func makeBody(configuration: Configuration) -> some View {
    configuration.title
  }
}
