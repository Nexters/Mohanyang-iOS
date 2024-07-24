//
//  AppCore.swift
//  AppServiceInterface
//
//  Created by devMinseok on 7/22/24.
//  Copyright © 2024 PomoNyang. All rights reserved.
//

import SwiftUI

import HomeFeature
import HomeFeatureInterface
import OnboardingFeature
import OnboardingFeatureInterface
import PushService

import ComposableArchitecture

@Reducer
public struct AppCore {
  @ObservableState
  public struct State: Equatable {
    public var appDelegate: AppDelegateCore.State = .init()
    var home: HomeCore.State?
    var onboarding: OnboardingCore.State?
    
    public init() {}
  }
  
  public enum Action {
    case onAppear
    case appDelegate(AppDelegateCore.Action)
    case didChangeScenePhase(ScenePhase)
    case home(HomeCore.Action)
    case onboarding(OnboardingCore.Action)
  }
  
  public init() {}
  
  public var body: some ReducerOf<Self> {
    Scope(state: \.appDelegate, action: \.appDelegate) {
      AppDelegateCore()
    }
    Reduce(self.core)
      .ifLet(\.home, action: \.home) {
        HomeCore()
      }
      .ifLet(\.onboarding, action: \.onboarding) {
        OnboardingCore()
      }
  }
  
  private func core(_ state: inout State, _ action: Action) -> EffectOf<Self> {
    switch action {
    case .onAppear:
      let isLoggedIn = true
      if isLoggedIn { // 로그인 판단
        state.home = HomeCore.State()
      } else {
        state.onboarding = OnboardingCore.State()
      }
      return .none
      
    case let .appDelegate(.userNotifications(.didReceiveResponse(response, completionHandler))):
      let userInfo = response.notification.request.content.userInfo
      guard let pushNotiContent = getPushNotificationContent(from: userInfo) else {
        completionHandler()
        return .none
      }
      return .run { _ in
        switch pushNotiContent {
        case .test:
          break
        }
        completionHandler()
      }
      
    case .appDelegate:
      return .none
      
    case .didChangeScenePhase:
      return .none
      
    case .home:
      return .none
      
    case .onboarding:
      return .none
    }
  }
}
