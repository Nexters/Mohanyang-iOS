//
//  CategorySelectView.swift
//  HomeFeature
//
//  Created by devMinseok on 8/13/24.
//  Copyright © 2024 PomoNyang. All rights reserved.
//

import SwiftUI

import DesignSystem

import ComposableArchitecture

public struct CategorySelectView: View {
  @Bindable var store: StoreOf<CategorySelectCore>
  
  public init(store: StoreOf<CategorySelectCore>) {
    self.store = store
  }
  
  public var body: some View {
    VStack {
      Color.red
        .frame(height: 400)
    }
    .onAppear {
      store.send(.onAppear)
    }
  }
}
