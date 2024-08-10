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
  let color: BoxButtonStyleColor
  let width: ButtonHuggingPriorityHorizontal
  
  public init(
    size: BoxButtonStyleSize,
    color: BoxButtonStyleColor,
    width: ButtonHuggingPriorityHorizontal
  ) {
    self.size = size
    self.color = color
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
      .foregroundColor(
        getForegroundColor(isPressed: configuration.isPressed)
      )
      .labelStyle(BoxButtonLabelStyle())
      .barButtonDetailStyle(BoxButtonDetailStyle())
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

extension ButtonStyle where Self == BoxButtonStyle {
  public static func box(
    size: BoxButtonStyleSize,
    color: BoxButtonStyleColor,
    width: ButtonHuggingPriorityHorizontal = .high
  ) -> Self {
    return BoxButtonStyle(size: size, color: color, width: width)
  }
}

struct BoxButtonDetailStyle: BarButtonDetailStyle {
  func makeBody(configuration: Configuration) -> some View {
    HStack(spacing: Alias.Spacing.small) {
      configuration.leftIcon
      configuration.title
      configuration.rightIcon
    }
  }
}

struct BoxButtonLabelStyle: LabelStyle {
  func makeBody(configuration: Configuration) -> some View {
    configuration.title
  }
}
