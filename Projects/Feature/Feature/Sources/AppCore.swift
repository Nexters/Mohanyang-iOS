//
//  AppCore.swift
//  Feature
//
//  Created by devMinseok on 7/22/24.
//  Copyright © 2024 PomoNyang. All rights reserved.
//

import SwiftUI

import SplashFeature
import HomeFeature
import OnboardingFeature
import MyPageFeature
import PushService
import AppService
import UserDefaultsClientInterface
import UserNotificationClientInterface
import CatServiceInterface
import UserServiceInterface
import DatabaseClientInterface

import ComposableArchitecture

@Reducer
public struct AppCore {
  @ObservableState
  public struct State: Equatable {
    public var appDelegate: AppDelegateCore.State = .init()
    var splash: SplashCore.State?
    var home: HomeCore.State?
    var onboarding: OnboardingCore.State?
    
    public init() {}
  }
  
  public enum Action {
    case onLoad
    case appDelegate(AppDelegateCore.Action)
    case didChangeScenePhase(ScenePhase)
    case splash(SplashCore.Action)
    case home(HomeCore.Action)
    case onboarding(OnboardingCore.Action)
  }
  
  @Dependency(UserDefaultsClient.self) var userDefaultsClient
  @Dependency(UserNotificationClient.self) var userNotificationClient
  @Dependency(UserService.self) var userService
  @Dependency(DatabaseClient.self) var databaseClient
  
  public init() {}
  
  public var body: some ReducerOf<Self> {
    Scope(state: \.appDelegate, action: \.appDelegate) {
      AppDelegateCore()
    }
    Reduce(self.core)
      .ifLet(\.splash, action: \.splash) {
        SplashCore()
      }
      .ifLet(\.home, action: \.home) {
        HomeCore()
      }
      .ifLet(\.onboarding, action: \.onboarding) {
        OnboardingCore()
      }
  }
  
  private func core(_ state: inout State, _ action: Action) -> EffectOf<Self> {
    switch action {
    case .onLoad:
      state.splash = SplashCore.State()
      return .none
      
    case let .appDelegate(.userNotifications(.didReceiveResponse(response, completionHandler))):
//      let userInfo = response.notification.request.content.userInfo
//      guard let pushNotiContent = getPushNotificationContent(from: userInfo) else {
//        completionHandler()
//        return .none
//      }
//      return .run { _ in
//        switch pushNotiContent {
//        case .test:
//          break
//        }
//        completionHandler()
//      }
      return .none
      
    case .appDelegate:
      return .none
      
    case .didChangeScenePhase(.background):
      let isDisturbAlarmEnabled = getDisturbAlarm(userDefaultsClient: self.userDefaultsClient)
      return .run { send in
        if isDisturbAlarmEnabled,
           let myCatInfo = try await self.userService.getUserInfo(databaseClient: self.databaseClient)?.cat {
          let trigger = UNTimeIntervalNotificationTrigger(
            timeInterval: TimeInterval(10),
            repeats: false
          )
          try await scheduleNotification(
            userNotificationClient: self.userNotificationClient,
            contentType: .disturb(SomeCat(baseInfo: myCatInfo)),
            trigger: trigger
          )
        }
      }
      
    case .didChangeScenePhase(.active):
      return .merge(
        .run { send in
          let settings = await self.userNotificationClient.getNotificationSettings()
          if settings.authorizationStatus != .authorized {
            await setTimerAlarm(userDefaultsClient: self.userDefaultsClient, isEnabled: false)
            await setDisturbAlarm(userDefaultsClient: self.userDefaultsClient, isEnabled: false)
          }
        },
        .run { _ in
          await removePendingNotification(userNotificationClient: self.userNotificationClient, identifier: ["disturb"])
        }
      )
      
    case .didChangeScenePhase:
      return .none

    case .splash(.moveToHome):
      state.splash = nil
      state.home = HomeCore.State()
      return .none

    case .splash(.moveToOnboarding):
      state.splash = nil
      state.onboarding = OnboardingCore.State()
      return .none

    case .splash:
      return .none

    case .home:
      return .none

    case .onboarding(.selectCat(.presented(.namingCat(.presented(.moveToHome))))):
      state.onboarding = nil
      state.home = HomeCore.State()
      return .none

    case .onboarding:
      return .none
    }
  }
}
