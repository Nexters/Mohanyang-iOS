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
  var onSubmit: (() -> Void)?
  var submitLabel: SubmitLabel

  public init(
    placeholder: String,
    text: Binding<String>,
    fieldError: Binding<T?> = .constant(nil),
    submitLabel: SubmitLabel = .return,
    onSubmit: (() -> Void)? = nil
  ) {
    self.placeholder = placeholder
    self._text = text
    self._fieldError = fieldError
    self.submitLabel = submitLabel
    self.onSubmit = onSubmit
  }

  public var body: some View {
    VStack(spacing: Alias.Spacing.small) {
      TextField(
        placeholder,
        text: $text,
        prompt: Text(placeholder)
          .foregroundStyle(Alias.Color.Text.disabled)
      )
      .textFieldStyle(.inputField($text, isError: fieldError != nil))
      .submitLabel(submitLabel)
      .onSubmit {
        onSubmit?()
      }

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
