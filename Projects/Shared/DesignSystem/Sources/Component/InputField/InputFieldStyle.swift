//
//  InputFieldStyle.swift
//  DesignSystem
//
//  Created by 김지현 on 8/17/24.
//  Copyright © 2024 PomoNyang. All rights reserved.
//

import SwiftUI
// 빠진 것 : placeholder color
struct InputFieldStyle: TextFieldStyle {
  @State private var isBorderShowed: Bool = false
  @FocusState private var isFocused: Bool
  @Environment(\.isEnabled) private var isEnabled

  @Binding var text: String
  var isError: Bool

  func _body(configuration: TextField<Self._Label>) -> some View {
    configuration
      .tint(Alias.Color.Accent.red)
      .padding(.all, Alias.Spacing.large)
      .frame(height: 56)
      .frame(maxWidth: .infinity)
      .font(Typography.bodySB)
      .foregroundStyle(Alias.Color.Text.primary)
      .background(Global.Color.white)
      .cornerRadius(Alias.BorderRadius.small, corners: .allCorners)
      .overlay(
        RoundedRectangle(cornerRadius: Alias.BorderRadius.small)
          .strokeBorder(getBorderColor(isBorderShowed: isBorderShowed || isError))
      )
      .focused($isFocused)
      .onChange(of: isFocused) {
        isBorderShowed = isFocused
      }
      .onChange(of: text) {
        isBorderShowed = false
      }
  }

  private func getBorderColor(isBorderShowed: Bool) -> Color {
    return isBorderShowed ? Alias.Color.Accent.red : Color.clear
  }
}

extension TextFieldStyle where Self == InputFieldStyle {
  static func inputField(_ text: Binding<String>, isError: Bool) -> Self {
    return InputFieldStyle(text: text, isError: isError)
  }
}
