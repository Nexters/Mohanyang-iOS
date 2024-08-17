//
//  BottomSheet.swift
//  DesignSystemExample
//
//  Created by devMinseok on 8/12/24.
//  Copyright © 2024 PomoNyang. All rights reserved.
//

import SwiftUI

struct BottomSheetViewModifier<
  Item: Identifiable,
  BottomSheetContent: View
>: ViewModifier {
  @Binding var item: Item?
  let bottomSheetContent: (Item) -> BottomSheetContent
  
  func body(content: Content) -> some View {
    ZStack(alignment: .bottom) {
      content
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .transaction { transaction in
          transaction.disablesAnimations = true
        }
        .zIndex(1)
      
      if let item {
        Global.Color.black.opacity(Global.Opacity._50d)
          .ignoresSafeArea()
          .onTapGesture {
            self.item = nil
          }
          .transition(
            .opacity.animation(.easeInOut)
          )
          .zIndex(2)
        VStack(spacing: .zero) {
          HStack(alignment: .center) {
            RoundedRectangle(cornerRadius: 2)
              .fill(Global.Color.gray400)
              .frame(width: 50, height: 4)
          }
          .frame(height: 30)
          .frame(maxWidth: .infinity)
          .background(Global.Color.white)
          .cornerRadius(24, corners: [.topLeft, .topRight])
          .gesture(
            DragGesture(minimumDistance: 20)
              .onEnded { value in
                if value.translation.height > 100 {
                  self.item = nil
                }
              }
          )
          
          bottomSheetContent(item)
            .frame(maxWidth: .infinity)
            .fixedSize(horizontal: false, vertical: true)
            .background(Global.Color.white)
        }
        .frame(maxWidth: .infinity)
        .frame(maxHeight: UIScreen.main.bounds.height * 0.9, alignment: .bottom)
        .transition(.move(edge: .bottom))
        .zIndex(3)
      }
    }
    .animation(.spring(duration: 0.4), value: self.item == nil)
  }
}

extension View {
  public func bottomSheet<
    Item: Identifiable,
    Content: View
  >(
    item: Binding<Item?>,
    @ViewBuilder content: @escaping (Item) -> Content
  ) -> some View {
    return self.modifier(BottomSheetViewModifier(item: item, bottomSheetContent: content))
  }
}
