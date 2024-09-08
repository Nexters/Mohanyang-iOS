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
import DatadogRUM

public struct SplashView: View {
  @Namespace var backgroundFrameID
  @Bindable var store: StoreOf<SplashCore>

  public init(store: StoreOf<SplashCore>) {
    self.store = store
  }
  public var body: some View {
    HStack {
      Spacer()
      VStack {
        Spacer()
        DesignSystemAsset.Image.appSymbol.swiftUIImage
        Spacer()
      }
      Spacer()
    }
    .background(Global.Color.yellow100)
    .setFrameMeasure(space: .global, identifier: backgroundFrameID)
    .getFrameMeasure { value in
      guard let frame = value[backgroundFrameID] else { return }
      store.width = frame.width
    }
    .dialog(dialog: $store.dialog)
    .task {
      await store.send(.task).finish()
    }
    .trackRUMView(name: "스플래시")
  }
}
