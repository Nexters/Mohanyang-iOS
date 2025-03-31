//
//  SelectListButtonStyle.swift
//  DesignSystem
//
//  Created by devMinseok on 8/13/24.
//  Copyright © 2024 PomoNyang. All rights reserved.
//

import SwiftUI

public struct SelectListButtonStyle: ButtonStyle {
  @Environment(\.isEnabled) var isEnabled
  let isSelected: Bool

  public init(isSelected: Bool) {
    self.isSelected = isSelected
  }
  
  public func makeBody(configuration: Configuration) -> some View {
    configuration.label
      .selectButtonDetailStyle(
        SelectListButtonDetailStyleImpl(
          isSelected: isSelected,
          isDisabled: !isEnabled
        )
      )
  }
}

extension ButtonStyle where Self == SelectListButtonStyle {
  public static func selectList(
    isSelected: Bool,
    isDisabled: Bool = false
  ) -> Self {
    return SelectListButtonStyle(isSelected: isSelected)
  }
}

struct SelectListButtonDetailStyleImpl: SelectButtonDetailStyle {
  let isSelected: Bool
  let isDisabled: Bool

  func makeBody(configuration: Configuration) -> some View {
    HStack(spacing: Alias.Spacing.medium) {
      HStack(spacing: Alias.Spacing.small) {
        Group {
          if isDisabled {
            DesignSystemAsset.Image.lock.swiftUIImage
              .renderingMode(.template)
              .resize(24)
              .foregroundStyle(Alias.Color.Icon.disabled)
          } else {
            configuration.leftIcon
          }
        }

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
