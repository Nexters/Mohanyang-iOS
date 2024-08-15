//
//  AppServcieView.swift
//  Feature
//
//  Created by devMinseok on 7/22/24.
//  Copyright © 2024 PomoNyang. All rights reserved.
//

import SwiftUI

import SplashFeature
import HomeFeature
import HomeFeatureInterface
import OnboardingFeature

import ComposableArchitecture

public struct AppView: View {
  let store: StoreOf<AppCore>
  
  public init(store: StoreOf<AppCore>) {
    self.store = store
  }
  
  public var body: some View {
    Group {
      if let splashStore = store.scope(state: \.splash, action: \.splash) {
        SplashView(store: splashStore)
      } else if let homeStore = store.scope(state: \.home, action: \.home) {
        HomeView(store: homeStore)
      } else if let onboardingStore = store.scope(state: \.onboarding, action: \.onboarding) {
        OnboardingView(store: onboardingStore)
      } else {
        Color.red
      }
    }
    .onAppear {
      store.send(.onAppear)
    }
  }
}
