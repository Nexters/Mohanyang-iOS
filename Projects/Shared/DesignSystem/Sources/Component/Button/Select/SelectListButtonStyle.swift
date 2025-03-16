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
        SelectListButtonDetailStyleImpl(
          isSelected: isSelected,
          isDisabled: isDisabled,
          iconSize: iconSize
        )
      )
  }
}

extension ButtonStyle where Self == SelectListButtonStyle {
  public static func selectList(
    isSelected: Bool,
    isDisabled: Bool = false,
    iconSize: CGSize = .init(width: 24, height: 24)
  ) -> Self {
    return SelectListButtonStyle(isSelected: isSelected, isDisabled: isDisabled, iconSize: iconSize)
  }
}

struct SelectListButtonDetailStyleImpl: SelectButtonDetailStyle {
  let isSelected: Bool
  let isDisabled: Bool
  let iconSize: CGSize

  func makeBody(configuration: Configuration) -> some View {
    HStack(spacing: Alias.Spacing.medium) {
      HStack(spacing: Alias.Spacing.small) {
        Group {
          if isDisabled {
            DesignSystemAsset.Image.lock.swiftUIImage
              .resizable()
              .renderingMode(.template)
              .foregroundStyle(Alias.Color.Icon.disabled)
          } else {
            configuration.leftIcon
          }
        }
        .frame(width: iconSize.width, height: iconSize.height)

        configuration.title
          .lineLimit(1)
          .font(Typography.bodySB)
          .foregroundStyle(getTitleForegroundColor())
      }
    }
    .frame(maxWidth: .infinity, alignment: .leading)
    .padding(Alias.Spacing.xLarge)
    .background(
      RoundedRectangle(cornerRadius: Alias.BorderRadius.small)
        .fill(getBackgroundColor())
        .strokeBorder(isSelected ? Alias.Color.Background.accent1 : .clear, lineWidth: 1)
    )
  }

  func getTitleForegroundColor() -> Color {
    if isDisabled {
      return Alias.Color.Text.disabled
    } else {
      return Alias.Color.Text.primary
    }
  }

  func getBackgroundColor() -> Color {
    if isSelected {
      return Alias.Color.Background.accent2
    } else {
      return Alias.Color.Background.primary
    }
  }
}
