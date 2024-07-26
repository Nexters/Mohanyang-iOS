//
//  HomeView.swift
//  HomeFeatureInterface
//
//  Created by devMinseok on 7/22/24.
//  Copyright © 2024 PomoNyang. All rights reserved.
//

import SwiftUI

import ComposableArchitecture

public struct HomeView: View {
  let store: StoreOf<HomeCore>
  
  public init(store: StoreOf<HomeCore>) {
    self.store = store
  }
  
  public var body: some View {
    VStack {
      Text("Home")
        .foregroundStyle(Color.black)
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .background(Color.white)
    .onAppear {
      store.send(.onAppear)
    }
  }
}
