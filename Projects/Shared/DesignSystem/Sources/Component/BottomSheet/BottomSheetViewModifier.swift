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
    //      .transaction { transaction in
    //        transaction.disablesAnimations = true
    //      }
      .updateBottomSheetBackground($item, Global.Color.black.opacity(Global.Opacity._50d))
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
  func updateBottomSheetBackground<Item: Identifiable>(_ item: Binding<Item?>, _ changeColor: Color) -> some View {
    self.modifier(BottomSheetBackgroundModifier(item: item, changeColor: changeColor))
  }
}

private struct BottomSheetBackgroundModifier<Item: Identifiable>: ViewModifier {
  @Binding var item: Item?
  let changeColor: Color
  
  func body(content: Content) -> some View {
    ZStack {
      content
      if item != nil {
        changeColor.ignoresSafeArea()
      }
    }
    .animation(.easeInOut, value: item != nil)
  }
}
