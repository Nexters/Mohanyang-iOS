//
//  NavigationBar.swift
//  DesignSystem
//
//  Created by devMinseok on 8/7/24.
//  Copyright © 2024 PomoNyang. All rights reserved.
//

import SwiftUI

struct NavigationBar<
  Title: View,
  Leading: View,
  Trailing: View,
  Background: ShapeStyle
>: View {
  let title: Title
  let leading: () -> Leading
  let trailing: () -> Trailing
  let style: NavigationBarStyle
  let background: Background
  let foregroundColor: Color
  let onDismiss: () -> Void
  
  init(
    title: Title,
    @ViewBuilder leading: @escaping () -> Leading,
    @ViewBuilder trailing: @escaping () ->  Trailing,
    style: NavigationBarStyle,
    background: Background,
    foregroundColor: Color,
    onDismiss: @escaping () -> Void
  ) {
    self.title = title
    self.leading = leading
    self.trailing = trailing
    self.style = style
    self.background = background
    self.foregroundColor = foregroundColor
    self.onDismiss = onDismiss
  }
  
  var body: some View {
    ZStack(alignment: .center) {
      self.title
        .font(Typography.bodySB)
        .lineLimit(1)
        .frame(maxWidth: .infinity, alignment: .center)
      HStack {
        switch style {
        case .modal:
          if Leading.self != EmptyView.self {
            self.leading()
          }
          Spacer()
          if Trailing.self == EmptyView.self {
            Button(
              icon: DesignSystemAsset.Image._24CancelPrimary.swiftUIImage,
              action: {
                self.onDismiss()
              }
            )
            .buttonStyle(.icon(isFilled: false, level: .primary))
            .foregroundStyle(foregroundColor)
          } else {
            self.trailing()
          }
          
        case .navigation:
          if Leading.self == EmptyView.self {
            Button(
              icon: DesignSystemAsset.Image._24ArrowLeftPrimary.swiftUIImage,
              action: {
                self.onDismiss()
              }
            )
            .buttonStyle(.icon(isFilled: false, level: .primary))
            .foregroundStyle(foregroundColor)
          } else {
            self.leading()
          }
          Spacer()
          if Leading.self != EmptyView.self {
            self.trailing()
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
