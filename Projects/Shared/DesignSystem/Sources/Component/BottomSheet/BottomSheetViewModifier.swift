//
//  BottomSheet.swift
//  DesignSystemExample
//
//  Created by devMinseok on 8/12/24.
//  Copyright © 2024 PomoNyang. All rights reserved.
//

import SwiftUI

struct BottomSheetViewModifier<
  Item: Identifiable & Equatable,
  BottomSheetContent: View
>: ViewModifier {
  @Binding var item: Item?
  let bottomSheetContent: (Item) -> BottomSheetContent
  @State var yOffset: CGFloat = 0
  
  func body(content: Content) -> some View {
    content
      .fullScreenCover(item: $item) { item in
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
        .presentationBackground(.clear)
      }
      .updateBottomSheetBackground($item)
  }
}

extension View {
  public func bottomSheet<
    Item: Identifiable & Equatable,
    Content: View
  >(
    item: Binding<Item?>,
    @ViewBuilder content: @escaping (Item) -> Content
  ) -> some View {
    return self.modifier(BottomSheetViewModifier(item: item, bottomSheetContent: content))
  }
}


extension View {
  func updateBottomSheetBackground<Item: Identifiable>(_ item: Binding<Item?>) -> some View {
    self.modifier(BottomSheetBackgroundModifier(item: item))
  }
}

struct BottomSheetBackgroundModifier<Item: Identifiable>: ViewModifier {
  @Binding var item: Item?
  @State var opacity: Double = 0
  
  func body(content: Content) -> some View {
    ZStack {
      content
      Global.Color.black.opacity(opacity)
        .ignoresSafeArea()
    }
    .onChange(of: item == nil) { _, value in
      withAnimation(.easeInOut) {
        opacity = value ? 0 : Global.Opacity._50d
      }
    }
  }
}
