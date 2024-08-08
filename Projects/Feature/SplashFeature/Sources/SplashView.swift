//
//  SplashView.swift
//  SplashFeature
//
//  Created by 김지현 on 8/9/24.
//  Copyright © 2024 PomoNyang. All rights reserved.
//

import SwiftUI

import DesignSystem

import ComposableArchitecture

public struct SplashView: View {
  let store: StoreOf<SplashCore>

  public init(store: StoreOf<SplashCore>) {
    self.store = store
  }
  public var body: some View {
    Text("Splash")
      .font(Typography.time)
  }
}
