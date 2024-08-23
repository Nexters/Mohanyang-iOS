//
//  Interface.swift
//  UserNotificationClient
//
//  Created by devMinseok on 7/20/24.
//  Copyright © 2024 PomoNyang. All rights reserved.
//

import Combine
import UserNotifications

import ComposableArchitecture

@DependencyClient
public struct UserNotificationClient {
  public var add: @Sendable (UNNotificationRequest) async throws -> Void
  public var delegate: @Sendable () -> AsyncStream<DelegateEvent> = { .finished }
  public var getNotificationSettings: @Sendable () async -> Notification.Settings = {
    Notification.Settings(authorizationStatus: .notDetermined)
  }
  public var removeDeliveredNotificationsWithIdentifiers: @Sendable ([String]) async -> Void
  public var removePendingNotificationRequestsWithIdentifiers: @Sendable ([String]) async -> Void
  public var requestAuthorization: @Sendable (UNAuthorizationOptions) async throws -> Bool
  
  @CasePathable
  public enum DelegateEvent {
    case didReceiveResponse(Notification.Response, completionHandler: @Sendable () -> Void)
    case openSettingsForNotification(Notification?)
    case willPresentNotification(
      Notification,
      completionHandler: @Sendable (UNNotificationPresentationOptions) -> Void
    )
  }
  
  public struct Notification: Equatable {
    public var date: Date
    public var request: UNNotificationRequest
    
    public init(
      date: Date,
      request: UNNotificationRequest
    ) {
      self.date = date
      self.request = request
    }
    
    public struct Response: Equatable {
      public var notification: Notification
      
      public init(notification: Notification) {
        self.notification = notification
      }
    }
    
    public struct Settings: Equatable {
      public var authorizationStatus: UNAuthorizationStatus
      
      public init(authorizationStatus: UNAuthorizationStatus) {
        self.authorizationStatus = authorizationStatus
      }
    }
  }
}

extension UserNotificationClient: TestDependencyKey {
  public static let previewValue = Self()
  public static let testValue = Self()
}
