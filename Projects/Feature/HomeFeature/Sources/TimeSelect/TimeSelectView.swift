//
//  TimeSelectView.swift
//  HomeFeature
//
//  Created by devMinseok on 8/13/24.
//  Copyright © 2024 PomoNyang. All rights reserved.
//

import SwiftUI

import DesignSystem

import ComposableArchitecture
import DatadogRUM

public struct TimeSelectView: View {
  @Bindable var store: StoreOf<TimeSelectCore>
  
  public init(store: StoreOf<TimeSelectCore>) {
    self.store = store
  }
  
  public var body: some View {
    NavigationContainer(
      style: .modal
    ) {
      VStack(spacing: .zero) {
        if let selectedCategory = store.selectedCategory {
          Button(
            title: .init(selectedCategory.title),
            leftIcon: selectedCategory.image
          ) {
            // no behavior
          }
          .buttonStyle(.text(level: .primary, size: .medium))
        }
        
        WheelPicker(
          image: store.mode == .focus ? DesignSystemAsset.Image._24Focus.swiftUIImage : DesignSystemAsset.Image._24Rest.swiftUIImage,
          sources: store.timeList,
          selection: $store.selectedTime.sending(\.pickerSelection)
        )
        
        Button(icon: DesignSystemAsset.Image._32CheckPrimary.swiftUIImage) {
          store.send(.bottomCheckButtonTapped)
        }
        .buttonStyle(.round(level: .secondary))
        .padding(.bottom, 40)
      }
    }
    .background(Global.Color.gray50)
    .onAppear {
      store.send(.onAppear)
    }
    .trackRUMView(name: "시간 변경")
  }
}
