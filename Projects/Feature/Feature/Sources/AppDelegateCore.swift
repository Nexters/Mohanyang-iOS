//
//  AppDelegateCore.swift
//  AppServiceInterface
//
//  Created by devMinseok on 7/22/24.
//  Copyright © 2024 PomoNyang. All rights reserved.
//

import UIKit
import Foundation

import UserNotificationClientInterface
import KeychainClientInterface

import ComposableArchitecture
import FirebaseCore
import FirebaseMessaging

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
  }
  
  @Dependency(\.keychainClient) var keychainClient
  @Dependency(\.userNotificationClient) var userNotificationClient
  
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
      UIApplication.shared.applicationIconBadgeNumber = 0
      FirebaseApp.configure()
      keychainClient.checkSubsequentRun()
      let userNotificationEventStream = userNotificationClient.delegate()
      
      return .run { send in
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
    }
  }
}
