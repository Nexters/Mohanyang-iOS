//
//  InputFieldDetailView.swift
//  DesignSystem
//
//  Created by 김지현 on 8/17/24.
//  Copyright © 2024 PomoNyang. All rights reserved.
//

import SwiftUI

import DesignSystem

enum ExampleInputFieldError: String, InputFieldErrorProtocol {
  case one, two, three

  var message: String {
    return self.rawValue
  }
}

struct InputFieldDetailView: View {
  @State var text: String = ""
  @State var error: ExampleInputFieldError? = nil

  var body: some View {
    VStack {
      Button(title: "random Error") {
        error = [ExampleInputFieldError.one, ExampleInputFieldError.two, ExampleInputFieldError.three].randomElement()
      }
      Button(title: "nil Error") {
        error = nil
      }

      InputField<ExampleInputFieldError>(
        placeholder: "Placeholder",
        text: $text,
        fieldError: $error
      )
      .padding(.horizontal, 20)
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .background(Alias.Color.Background.primary)
  }
}

#Preview {
  InputFieldDetailView()
}
