//
//  NavigationContainer.swift
//  DesignSystem
//
//  Created by devMinseok on 8/7/24.
//  Copyright © 2024 PomoNyang. All rights reserved.
//

import Foundation

import SwiftUI

/// 기본 NavigationBar
/// - content는 기본적으로 VStack(spacing: .zero){} 를 적용받습니다
public struct NavigationContainer<
  Content: View,
  Title: View,
  Leading: View,
  Trailing: View,
  Background: ShapeStyle
>: View {
  @Environment(\.dismiss) var _dismiss
  
  private let title: Title
  private let leading: () -> Leading
  private let trailing: () -> Trailing
  private let style: NavigationBarStyle
  private let navBackground: Background
  private let navForegroundColor: Color
  private let onDismiss: () -> Void
  private let content: () -> Content
  
  public init(
    title: Title = EmptyView(),
    @ViewBuilder leading: @escaping () -> Leading = { EmptyView() },
    @ViewBuilder trailing: @escaping () -> Trailing = { EmptyView() },
    style: NavigationBarStyle,
    navBackground: Background = Global.Color.gray50,
    navForegroundColor: Color = Alias.Color.Text.primary,
    onDismiss: @escaping () -> Void = {},
    @ViewBuilder content: @escaping () -> Content
  ) {
    self.title = title
    self.leading = leading
    self.trailing = trailing
    self.style = style
    self.navBackground = navBackground
    self.navForegroundColor = navForegroundColor
    self.onDismiss = onDismiss
    self.content = content
  }
  
  public var body: some View {
    VStack(spacing: .zero) {
      NavigationBar(
        title: self.title,
        leading: self.leading,
        trailing: self.trailing,
        style: self.style,
        background: self.navBackground,
        foregroundColor: self.navForegroundColor,
        onDismiss: {
          self._dismiss()
          self.onDismiss()
        }
      )
      self.content()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .navigationBarHidden(true)
  }
}
