//
//  SelectButtonStyle.swift
//  DesignSystem
//
//  Created by devMinseok on 8/13/24.
//  Copyright © 2024 PomoNyang. All rights reserved.
//

import SwiftUI

public struct SelectButtonStyle: ButtonStyle {
  @Environment(\.isEnabled) var isEnabled
  let isSelected: Bool
  let iconSize: CGSize

  public init(isSelected: Bool, iconSize: CGSize) {
    self.isSelected = isSelected
    self.iconSize = iconSize
  }
  
  public func makeBody(configuration: Configuration) -> some View {
    configuration.label
      .selectButtonDetailStyle(
        SelectButtonDetailStyleImpl(
          isSelected: isSelected,
          isDisabled: !isEnabled,
          iconSize: iconSize
        )
      )
  }
}

extension ButtonStyle where Self == SelectButtonStyle {
  public static func select(
    isSelected: Bool,
    iconSize: CGSize = .init(width: 16, height: 16)
  ) -> Self {
    return SelectButtonStyle(isSelected: isSelected, iconSize: iconSize)
  }
}

struct SelectButtonDetailStyleImpl: SelectButtonDetailStyle {
  let isSelected: Bool
  let isDisabled: Bool
  let iconSize: CGSize

  func makeBody(configuration: Configuration) -> some View {
    VStack(spacing: Alias.Spacing.xSmall) {
      HStack(spacing: Alias.Spacing.xSmall) {
        configuration.leftIcon
          .frame(width: iconSize.width, height: iconSize.height)
        configuration.subtitle
          .font(Typography.subBodyR)
          .foregroundStyle(getSubtitleForegourndColor())
        configuration.rightIcon
          .frame(width: iconSize.width, height: iconSize.height)
      }
      configuration.title
        .font(Typography.header5)
        .foregroundStyle(getTitleForegourndColor())
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .background(
      RoundedRectangle(cornerRadius: Alias.BorderRadius.xSmall)
        .fill(getBackgroundColor())
        .strokeBorder(isSelected ? Alias.Color.Background.accent1 : .clear, lineWidth: 1)
    )
  }
  
  func getTitleForegourndColor() -> Color {
    if isDisabled {
      return Alias.Color.Text.disabled
    } else {
      if isSelected {
        return Alias.Color.Text.primary
      } else {
        return Alias.Color.Text.secondary
      }
    }
  }
  
  func getSubtitleForegourndColor() -> Color {
    if isDisabled {
      return Alias.Color.Text.disabled
    } else {
      return Alias.Color.Text.tertiary
    }
  }
  
  func getBackgroundColor() -> Color {
    if isSelected {
      return Alias.Color.Background.accent2
    } else {
      return Alias.Color.Background.secondary
    }
  }
}
