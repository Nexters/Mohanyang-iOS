//
//  NavigationBar.swift
//  DesignSystem
//
//  Created by devMinseok on 8/7/24.
//  Copyright © 2024 PomoNyang. All rights reserved.
//

import SwiftUI

struct NavigationBar<Title: View, Trailing: View, Background: ShapeStyle>: View {
  let title: Title
  let trailing: Trailing
  let style: NavigationBarStyle
  let background: Background
  let foregroundColor: Color
  let onDismiss: () -> Void
  
  init(
    title: Title,
    trailing: Trailing,
    style: NavigationBarStyle,
    background: Background,
    foregroundColor: Color,
    onDismiss: @escaping () -> Void
  ) {
    self.title = title
    self.trailing = trailing
    self.style = style
    self.background = background
    self.foregroundColor = foregroundColor
    self.onDismiss = onDismiss
  }
  
  var body: some View {
    ZStack(alignment: style == .bottomSheet ? .leading : .center) {
      self.title
        .font(Typography.bodySB)
        .lineLimit(1)
        .frame(maxWidth: .infinity, alignment: .center)
      HStack {
        switch style {
        case .modal:
          Button {
            self.onDismiss()
          } label: {
            DesignSystemAsset.Image._24CancelPrimary.swiftUIImage
              .renderingMode(.template)
              .foregroundStyle(foregroundColor)
          }
          Spacer()
          self.trailing
          
        case .navigation:
          Button {
            self.onDismiss()
          } label: {
            DesignSystemAsset.Image._24ArrowLeftPrimary.swiftUIImage
              .renderingMode(.template)
              .foregroundStyle(foregroundColor)
          }
          Spacer()
          self.trailing
          
        case .bottomSheet:
          Spacer()
          Button {
            self.onDismiss()
          } label: {
            DesignSystemAsset.Image._24CancelPrimary.swiftUIImage
              .renderingMode(.template)
              .foregroundStyle(foregroundColor)
          }
        }
      }
    }
    .padding(.horizontal, 10)
    .frame(maxWidth: .infinity)
    .frame(height: 56)
    .background(background)
    .foregroundStyle(foregroundColor)
  }
}
