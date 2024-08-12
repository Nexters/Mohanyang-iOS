//
//  BottomSheet.swift
//  DesignSystemExample
//
//  Created by devMinseok on 8/12/24.
//  Copyright © 2024 PomoNyang. All rights reserved.
//

import SwiftUI

extension View {
  public func bottomSheet<
    Item: Identifiable,
    Content: View
  >(
    item: Binding<Item?>,
    @ViewBuilder content: @escaping (Item) -> Content
  ) -> some View {
    ZStack(alignment: .bottom) {
      self
        .zIndex(1)
      
      if let wrappedItem = item.wrappedValue {
        Global.Color.black.opacity(Global.Opacity._50d)
          .ignoresSafeArea()
          .onTapGesture {
            item.wrappedValue = nil
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
                  withAnimation {
                    item.wrappedValue = nil
                  }
                }
              }
          )
          
          content(wrappedItem)
            .frame(maxWidth: .infinity)
            .fixedSize(horizontal: false, vertical: true)
            .background(Global.Color.white)
        }
        .frame(maxWidth: .infinity)
        .frame(maxHeight: UIScreen.main.bounds.height * 0.9, alignment: .bottom)
        .transition(.move(edge: .bottom))
        .animation(.spring(duration: 0.4))
        .zIndex(3)
      }
    }
  }
}
