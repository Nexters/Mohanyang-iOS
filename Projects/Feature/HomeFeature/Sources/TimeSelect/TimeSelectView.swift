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
          image: DesignSystemAsset.Image._24Focus.swiftUIImage,
          sources: store.timeList,
          selection: $store.selectedTime.sending(\.pickerSelection)
        )
        
        Button(
          icon: DesignSystemAsset.Image._32PlayPrimary.swiftUIImage,
          action: {
            
          }
        )
        .buttonStyle(.round(level: .secondary))
        .padding(.bottom, 40)
      }
    }
    .background(Global.Color.gray50)
    .onAppear {
      store.send(.onAppear)
    }
  }
}


public struct TimeItem: WheelPickerData {
  public let id: UUID = .init()
  let title: String
  let data: Int
  
  init(
    title: String,
    data: Int
  ) {
    self.title = title
    self.data = data
  }
}
