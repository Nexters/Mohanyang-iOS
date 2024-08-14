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
      VStack {
        Button(
          title: "작업",
          leftIcon: DesignSystemAsset.Image._24WorkPrimary.swiftUIImage,
          action: {}
        )
        .buttonStyle(.text(level: .primary, size: .medium))
        
        Spacer()
        
        Button(
          icon: DesignSystemAsset.Image._32PlayPrimary.swiftUIImage,
          action: {
            
          }
        )
        .buttonStyle(.round(level: .secondary))
        .padding(.vertical, 40)
      }
    }
  }
}
