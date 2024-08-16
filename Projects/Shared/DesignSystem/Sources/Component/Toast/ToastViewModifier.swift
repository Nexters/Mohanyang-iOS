//
//  ToastView.swift
//  DesignSystem
//
//  Created by devMinseok on 8/16/24.
//  Copyright © 2024 PomoNyang. All rights reserved.
//

import SwiftUI

struct ToastViewModifier<T: Toast>: ViewModifier {
  @Binding var toast: T?
  
  init(toast: Binding<T?>) {
    _toast = toast
  }
  
  func body(content: Content) -> some View {
    ZStack(alignment: .bottom ) {
      content
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .zIndex(1)
      
      if let toast {
        HStack(alignment: .center, spacing: 8) {
          if let image = toast.image {
            image
          }
          Text(toast.message)
            .foregroundStyle(Global.Color.white)
            .font(Typography.subBodyR)
            .multilineTextAlignment(.leading)
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding(16)
        .background(
          RoundedRectangle(cornerRadius: 16)
            .fill(Alias.Color.Background.inverse)
            .opacity(Global.Opacity._90d)
        )
        .padding(.horizontal, Global.Dimension._20f)
        .transition(
          .move(edge: .bottom)
          .combined(with: .opacity.animation(.easeInOut))
        )
        .onAppear {
          if toast.hideAutomatically {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
              if self.toast != nil {
                self.toast = nil
              }
            }
          }
        }
        .onTapGesture {
          self.toast = nil
        }
        .zIndex(2)
      }
    }
    .animation(.spring(duration: 0.3), value: self.toast)
  }
}

extension View {
  public func toastDestination<T: Toast>(
    toast: Binding<T?>
  ) -> some View {
    self.modifier(ToastViewModifier(toast: toast))
  }
}
