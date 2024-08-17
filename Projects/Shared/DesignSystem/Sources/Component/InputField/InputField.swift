//
//  InputField.swift
//  DesignSystem
//
//  Created by 김지현 on 8/17/24.
//  Copyright © 2024 PomoNyang. All rights reserved.
//

import SwiftUI

public protocol InputFieldErrorProtocol {
  var message: String { get }
}

public struct InputField<T: InputFieldErrorProtocol>: View {
  var placeholder: String
  @Binding var text: String
  @Binding var fieldError: T?

  public init(
    placeholder: String,
    text: Binding<String>,
    fieldError: Binding<T?> = .constant(nil)
  ) {
    self.placeholder = placeholder
    self._text = text
    self._fieldError = fieldError
  }

  // MARK: Placeholder Color를 TextFieldStyle 내부에서 변경하는 방법 Plz...
  public var body: some View {
    VStack(spacing: Alias.Spacing.small) {
      TextField(
        placeholder,
        text: $text,
        prompt: Text(placeholder)
          .foregroundStyle(Alias.Color.Text.disabled)
      )
      .textFieldStyle(.inputField($text, isError: fieldError != nil))

      HStack {
        Text(fieldError?.message ?? "")
          .font(Typography.captionR)
          .foregroundStyle(Alias.Color.Accent.red)
        Spacer()
      }
      .padding(.horizontal, Alias.Spacing.xSmall)
    }
  }
}
