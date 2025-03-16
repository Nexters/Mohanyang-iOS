//
//  SelectChipButtonStyle.swift
//  DesignSystem
//
//  Created by devMinseok on 8/24/24.
//  Copyright © 2024 PomoNyang. All rights reserved.
//

import SwiftUI

public struct SelectChipButtonStyle: ButtonStyle {
  let isSelected: Bool
  let isDisabled: Bool
  let iconSize: CGSize

  public init(
    isSelected: Bool,
    isDisabled: Bool,
    iconSize: CGSize
  ) {
    self.isSelected = isSelected
    self.isDisabled = isDisabled
    self.iconSize = iconSize
  }
  
  public func makeBody(configuration: Configuration) -> some View {
    configuration.label
      .selectButtonDetailStyle(
        SelectChipButtonStyleImpl(
          isSelected: isSelected,
          isDisabled: isDisabled,
          iconSize: iconSize
        )
      )
  }
}

extension ButtonStyle where Self == SelectChipButtonStyle {
  public static func selectChip(
    isSelected: Bool,
    isDisabled: Bool,
    iconSize: CGSize = .init(width: 16, height: 16)
  ) -> Self {
    return SelectChipButtonStyle(isSelected: isSelected, isDisabled: isDisabled, iconSize: iconSize)
  }
}

struct SelectChipButtonStyleImpl: SelectButtonDetailStyle {
  let isSelected: Bool
  let isDisabled: Bool
  let iconSize: CGSize

  func makeBody(configuration: Configuration) -> some View {
    HStack(spacing: Alias.Spacing.xSmall) {
      configuration.leftIcon
        .frame(width: iconSize.width, height: iconSize.height)
      configuration.subtitle
        .font(Typography.bodySB)
        .foregroundStyle(getSubtitleForegroundColor())
      configuration.rightIcon
        .frame(width: iconSize.width, height: iconSize.height)
    }
    .padding(.horizontal, Alias.Spacing.medium)
    .padding(.vertical, Alias.Spacing.small)
    .background(
      RoundedRectangle(cornerRadius: Alias.BorderRadius.xSmall)
        .fill(getBackgroundColor())
        .strokeBorder(isSelected ? Alias.Color.Background.accent1 : .clear, lineWidth: 1)
    )
  }
  
  func getSubtitleForegroundColor() -> Color {
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
