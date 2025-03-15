//
//  SelectListButtonStyle.swift
//  DesignSystem
//
//  Created by devMinseok on 8/13/24.
//  Copyright © 2024 PomoNyang. All rights reserved.
//

import SwiftUI

public struct SelectListButtonStyle: ButtonStyle {
  let isSelected: Bool
  let iconSize: CGSize

  public init(isSelected: Bool, iconSize: CGSize) {
    self.isSelected = isSelected
    self.iconSize = iconSize
  }
  
  public func makeBody(configuration: Configuration) -> some View {
    configuration.label
      .selectButtonDetailStyle(
        SelectListButtonDetailStyleImpl(
          isSelected: isSelected,
          iconSize: iconSize
        )
      )
  }
}

extension ButtonStyle where Self == SelectListButtonStyle {
  public static func selectList(
    isSelected: Bool,
    iconSize: CGSize = .init(width: 24, height: 24)
  ) -> Self {
    return SelectListButtonStyle(isSelected: isSelected, iconSize: iconSize)
  }
}

struct SelectListButtonDetailStyleImpl: SelectButtonDetailStyle {
  let isSelected: Bool
  let iconSize: CGSize

  func makeBody(configuration: Configuration) -> some View {
    HStack(spacing: Alias.Spacing.medium) {
      HStack(spacing: Alias.Spacing.small) {
        configuration.leftIcon
          .frame(width: iconSize.width, height: iconSize.height)
        configuration.title
          .font(Typography.bodySB)
          .foregroundStyle(Alias.Color.Text.primary)
      }
      configuration.subtitle
        .font(Typography.subBodyR)
        .foregroundStyle(Alias.Color.Text.tertiary)
    }
    .frame(maxWidth: .infinity, alignment: .leading)
    .padding(Alias.Spacing.xLarge)
    .background(
      RoundedRectangle(cornerRadius: Alias.BorderRadius.small)
        .fill(getBackgroundColor())
        .strokeBorder(isSelected ? Alias.Color.Background.accent1 : .clear, lineWidth: 1)
    )
  }
  
  func getBackgroundColor() -> Color {
    if isSelected {
      return Alias.Color.Background.accent2
    } else {
      return Alias.Color.Background.primary
    }
  }
}
