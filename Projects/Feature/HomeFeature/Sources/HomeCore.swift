//
//  HomeCore.swift
//  HomeFeature
//
//  Created by devMinseok on 7/22/24.
//  Copyright © 2024 PomoNyang. All rights reserved.
//

import UserNotifications

import HomeFeatureInterface
import PushService
import UserNotificationClientInterface

import ComposableArchitecture

extension HomeCore {
  public init() {
    @Dependency(\.userNotificationClient) var userNotificationClient
    
    let reducer = Reduce<State, Action> { _, action  in
      switch action {
      case .onAppear:
        return .run { send in
          _ = try await userNotificationClient.requestAuthorization([.alert, .badge, .sound])
        }
        
      case .localPushButtonTapped:
        return .run { send in
          do {
            try await scheduleNotification(
              userNotificationClient: userNotificationClient,
              contentType: .test,
              trigger: UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
            )
          } catch {
            print(error)
          }
        }
      }
    }
    self.init(reducer: reducer)
  }
}
