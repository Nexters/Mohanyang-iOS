//
//  AppDelegateCore.swift
//  Feature
//
//  Created by devMinseok on 7/22/24.
//  Copyright © 2024 PomoNyang. All rights reserved.
//

import UIKit
import Foundation
import Logger

import UserNotificationClientInterface
import KeychainClientInterface
import DatabaseClientInterface
import LiveActivityClientInterface
import BackgroundTaskClientInterface
import APIClientInterface
import AppService
import PomodoroServiceInterface

import ComposableArchitecture
import FirebaseCore
import FirebaseMessaging
import DatadogCore
import DatadogRUM

@Reducer
public struct AppDelegateCore {
  @ObservableState
  public struct State: Equatable {
    public init() {}
  }
  
  public enum Action {
    case didFinishLaunching
    case didRegisterForRemoteNotifications(Result<Data, Error>)
    case userNotifications(UserNotificationClient.DelegateEvent)
    case willTerminate
  }
  
  @Dependency(KeychainClient.self) var keychainClient
  @Dependency(UserNotificationClient.self) var userNotificationClient
  @Dependency(LiveActivityClient.self) var liveActivityClient
  @Dependency(PomodoroService.self) var pomodoroService
  @Dependency(BackgroundTaskClient.self) var backgroundTaskClient
  
  public init() {}
  
  public var body: some ReducerOf<Self> {
    Reduce(self.core)
  }
  
  private func core(
    _ state: inout State,
    _ action: Action
  ) -> EffectOf<Self> {
    switch action {
    case .didFinishLaunching:
      firebaseInitilize()
      datadogInitilize()
      
      Logger.shared.log("FCMToken: \(Messaging.messaging().fcmToken ?? "not generated")")
      
      let userNotificationEventStream = userNotificationClient.delegate()
      
//      pomodoroService.registerTimerOverTime(
//        bgTaskClient: backgroundTaskClient,
//        liveActivityClient: liveActivityClient
//      )
      
      return .run { send in
        try await userNotificationClient.setBadgeCount(0)
        await withThrowingTaskGroup(of: Void.self) { group in
          group.addTask {
            for await event in userNotificationEventStream {
              await send(.userNotifications(event))
            }
          }
          
          group.addTask {
            let settings = await userNotificationClient.getNotificationSettings()
            switch settings.authorizationStatus {
            case .authorized:
              guard try await userNotificationClient.requestAuthorization([.badge, .alert, .sound])
              else { return }
            case .notDetermined, .provisional:
              guard try await userNotificationClient.requestAuthorization(.provisional)
              else { return }
            default:
              return
            }
            await UIApplication.shared.registerForRemoteNotifications()
          }
        }
      }
      
    case let .didRegisterForRemoteNotifications(.success(tokenData)):
      Messaging.messaging().apnsToken = tokenData
      return .none
      
    case .didRegisterForRemoteNotifications(.failure):
      return .none
      
    case let .userNotifications(.willPresentNotification(_, completionHandler)):
      completionHandler([.banner, .list, .sound])
      return .none
      
    case .userNotifications:
      return .none
      
    case .willTerminate:
      return .run { _ in
        await liveActivityClient.protocolAdapter.endAllActivityImmediately(type: PomodoroActivityAttributes.self)
      }
    }
  }
}

extension AppDelegateCore {
  private func firebaseInitilize() {
    FirebaseApp.configure()
  }
  
  private func datadogInitilize() {
    // TODO: - 환경 값 가져오는 부분 개선하기
    guard let appID = Bundle.main.object(forInfoDictionaryKey: "DATADOG_APP_ID") as? String,
          let clientToken = Bundle.main.object(forInfoDictionaryKey: "DATADOG_TOKEN") as? String
    else { return }
    
#if DEV
    let environment = "dev"
#else
    let environment = "prod"
#endif
    
    Datadog.initialize(
      with: Datadog.Configuration(
        clientToken: clientToken,
        env: environment,
        site: .us5
      ),
      trackingConsent: .granted
    )
    
    RUM.enable(
      with: RUM.Configuration(
        applicationID: appID,
        uiKitViewsPredicate: DefaultUIKitRUMViewsPredicate(),
        uiKitActionsPredicate: DefaultUIKitRUMActionsPredicate(),
        urlSessionTracking: RUM.Configuration.URLSessionTracking(
          firstPartyHostsTracing: .trace(hosts: [API.apiBaseHost], sampleRate: 20)
        ),
        trackBackgroundEvents: true
      )
    )
    
    URLSessionInstrumentation.enable(
      with: URLSessionInstrumentation.Configuration(
        delegateClass: APIClientURLSessionDelegate.self,
        firstPartyHostsTracing: .trace(hosts: [API.apiBaseHost])
      )
    )
  }
}
