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
import ErrorFeature

import ComposableArchitecture
import Lottie

public struct AppView: View {
  @Bindable var store: StoreOf<AppCore>

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
    .fullScreenCover(isPresented: $store.isLoading) {
      VStack {
        Spacer()
        ZStack {
          RoundedRectangle(cornerRadius: Alias.BorderRadius.medium)
            .foregroundStyle(Alias.Color.Background.inverse)
            .opacity(Global.Opacity._90d)
          LottieView(animation: AnimationAsset.lotiSpinner.animation)
            .playing(loopMode: .loop)
        }
        .frame(width: 82, height: 82)
        Spacer()
      }
      .presentationBackground(.clear)
      // transaction으로 로딩뷰만 애니메이션을 disable하고싶은데 잘 안됨
    }
    .transaction(value: store.isLoading) { transaction in
      transaction.disablesAnimations = true
    }
    .fullScreenCover(isPresented: $store.isErrorOccured) {
      RequestErrorView()
    }
    .fullScreenCover(isPresented: $store.isNetworkDisabled) {
      NetworkErrorView()
    }

  }
}
