//
//  OverlayWithOnPreferenceChange.swift
//  DesignSystem
//
//  Created by devMinseok on 8/9/24.
//  Copyright © 2024 PomoNyang. All rights reserved.
//

import SwiftUI

struct OverlayWithOnPreferenceChange<
  K, OverlayContent
>: ViewModifier where K: PreferenceKey, K.Value: Equatable, OverlayContent: View {
  let preferenceKey: K.Type
  let contentForOverlay: (K.Value) -> OverlayContent
  @State var value: K.Value?
  
  init(
    preferenceKey: K.Type,
    @ViewBuilder contentForOverlay: @escaping (K.Value) -> OverlayContent
  ) {
    self.preferenceKey = preferenceKey
    self.contentForOverlay = contentForOverlay
  }
  
  func body(content: Content) -> some View {
    content
      .overlay {
        if let value {
          contentForOverlay(value)
        }
      }
      .onPreferenceChange(preferenceKey) { value in
        self.value = value
      }
  }
}

extension View {
  func overlayWithOnPreferenceChange<K, Content>(
    _ key: K.Type,
    @ViewBuilder content: @escaping (K.Value) -> Content
  ) -> some View where K: PreferenceKey, K.Value: Equatable, Content: View {
    modifier(
      OverlayWithOnPreferenceChange(
        preferenceKey: key,
        contentForOverlay: content
      )
    )
  }
}
