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
  
  public init(isSelected: Bool) {
    self.isSelected = isSelected
  }
  
  public func makeBody(configuration: Configuration) -> some View {
    configuration.label
      .selectButtonDetailStyle(SelectListButtonDetailStyleImpl(isSelected: isSelected))
  }
}

extension ButtonStyle where Self == SelectListButtonStyle {
  public static func selectList(
    isSelected: Bool
  ) -> Self {
    return SelectListButtonStyle(isSelected: isSelected)
  }
}

struct SelectListButtonDetailStyleImpl: SelectButtonDetailStyle {
  let isSelected: Bool
  
  func makeBody(configuration: Configuration) -> some View {
    HStack(spacing: Alias.Spacing.medium) {
      HStack(spacing: Alias.Spacing.small) {
        configuration.leftIcon
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
