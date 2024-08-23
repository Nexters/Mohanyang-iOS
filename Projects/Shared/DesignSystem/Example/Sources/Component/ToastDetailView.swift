//
//  ToastDetailView.swift
//  DesignSystemExample
//
//  Created by devMinseok on 8/16/24.
//  Copyright © 2024 PomoNyang. All rights reserved.
//

import SwiftUI

import DesignSystem

struct ToastDetailView: View {
  @State var toast: DefaultToast?
  
  var body: some View {
    VStack {
      Button {
        toast = DefaultToast(message: "Thist is test message for toast", image: Image(systemName: "left"))
      } label: {
        Text("showToast")
      }
    }
    .toastDestination(toast: $toast)
  }
}

#Preview {
  ToastDetailView()
}
