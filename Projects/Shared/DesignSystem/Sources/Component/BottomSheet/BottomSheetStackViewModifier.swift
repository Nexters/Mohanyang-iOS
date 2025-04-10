//
//  BottomSheetStackViewModifier.swift
//  DesignSystem
//
//  Created by 김지현 on 3/20/25.
//  Copyright © 2025 PomoNyang. All rights reserved.
//

import SwiftUI
import Utils

struct BottomSheetStackViewModifier<
  Item: Identifiable & Equatable,
  BottomSheetContent: View
>: ViewModifier {
  @Binding var item: Item?
  let bottomSheetContent: (Item) -> BottomSheetContent

  func body(content: Content) -> some View {
    ZStack(alignment: .bottom) {
      content
        .updateBottomSheetBackground($item)
        .zIndex(1)
      if let item {
        VStack(spacing: .zero) {
          Color.black.opacity(0.001)
            .onTapGesture {
              self.item = nil
            }
          bottomSheetContent(item)
            .padding(.top, 30)
            .background(
              Global.Color.white
                .cornerRadius(24, corners: [.topLeft, .topRight])
                .ignoresSafeArea()
            )
            .overlay(alignment: .top) {
              HStack(alignment: .center) {
                RoundedRectangle(cornerRadius: 2)
                  .fill(Global.Color.gray400)
                  .frame(width: 50, height: 4)
              }
              .frame(maxWidth: .infinity)
              .frame(height: 30)
            }
        }
        .transition(.move(edge: .bottom).combined(with: .opacity))
        .zIndex(2)
      }
    }
    .animation(.spring(duration: 0.3), value: item == nil)
  }
}


extension View {
  public func bottomSheetStack<
    Item: Identifiable & Equatable,
    Content: View
  >(
    item: Binding<Item?>,
    @ViewBuilder content: @escaping (Item) -> Content
  ) -> some View {
    return self.modifier(BottomSheetStackViewModifier(item: item, bottomSheetContent: content))
  }
}
