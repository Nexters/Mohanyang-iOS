//
//  HomeCore.swift
//  HomeFeature
//
//  Created by devMinseok on 7/22/24.
//  Copyright © 2024 PomoNyang. All rights reserved.
//

import UserNotifications

import APIClientInterface
import AuthServiceInterface
import HomeFeatureInterface
import PushService
import UserNotificationClientInterface

import ComposableArchitecture

extension HomeCore {
  public init() {
    @Dependency(UserNotificationClient.self) var userNotificationClient
    @Dependency(APIClient.self) var apiClient
    @Dependency(AuthAPIClient.self) var authAPIClient

    let reducer = Reduce<State, Action> { _, action  in
      switch action {
      case .onAppear:
        return .run { send in
          _ = try await userNotificationClient.requestAuthorization([.alert, .badge, .sound])
          _ = try await authAPIClient.login(deviceID: "deviceID", apiClient: apiClient)
        }
        
      case .localPushButtonTapped:
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 10, repeats: false)
        return .run { send in
          do {
            try await scheduleNotification(
              userNotificationClient: userNotificationClient,
              contentType: .test,
              trigger: trigger
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
