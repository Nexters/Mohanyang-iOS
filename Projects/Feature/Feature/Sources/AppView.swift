//
//  AppServcieView.swift
//  Feature
//
//  Created by devMinseok on 7/22/24.
//  Copyright © 2024 PomoNyang. All rights reserved.
//

import SwiftUI

import DesignSystem
import SplashFeature
import HomeFeature
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
          .zIndex(0)
      } else if let onboardingStore = store.scope(state: \.onboarding, action: \.onboarding) {
        NavigationStack {
          OnboardingView(store: onboardingStore)
            .zIndex(1)
        }
      } else if let homeStore = store.scope(state: \.home, action: \.home) {
        NavigationStack {
          HomeView(store: homeStore)
            .zIndex(2)
        }
      } else {
        Global.Color.black // MARK: - DB정보 없고 오프라인일때 Dialog 띄우기
          .zIndex(3)
      }
    }
    .transition(.opacity)
    .animation(.easeInOut, value: store.home == nil)
    .onLoad {
      store.send(.onLoad)
    }
  }
}
