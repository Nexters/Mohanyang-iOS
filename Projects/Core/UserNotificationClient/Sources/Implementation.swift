//
//  Implementation.swift
//  UserNotificationClient
//
//  Created by devMinseok on 7/20/24.
//  Copyright © 2024 PomoNyang. All rights reserved.
//

import Combine
import UserNotifications

import UserNotificationClientInterface

import Dependencies

extension UserNotificationClient: DependencyKey {
  public static let liveValue = Self(
    add: {
      try await UNUserNotificationCenter.current().add($0)
    },
    delegate: {
      AsyncStream { continuation in
        let delegate = Delegate(continuation: continuation)
        UNUserNotificationCenter.current().delegate = delegate
        continuation.onTermination = { _ in
          _ = delegate
        }
      }
    },
    getNotificationSettings: {
      await Notification.Settings(
        rawValue: UNUserNotificationCenter.current().notificationSettings()
      )
    },
    removeDeliveredNotificationsWithIdentifiers: {
      UNUserNotificationCenter.current().removeDeliveredNotifications(withIdentifiers: $0)
    },
    removePendingNotificationRequestsWithIdentifiers: {
      UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: $0)
    },
    removeAllPendingNotificationRequests: {
      UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
    },
    requestAuthorization: {
      try await UNUserNotificationCenter.current().requestAuthorization(options: $0)
    },
    setBadgeCount: { badgeCount in
      try await UNUserNotificationCenter.current().setBadgeCount(badgeCount)
    }
  )
}

extension UserNotificationClient.Notification {
  public init(rawValue: UNNotification) {
    self.init(date: rawValue.date, request: rawValue.request)
  }
}

extension UserNotificationClient.Notification.Response {
  public init(rawValue: UNNotificationResponse) {
    self.init(notification: .init(rawValue: rawValue.notification))
  }
}

extension UserNotificationClient.Notification.Settings {
  public init(rawValue: UNNotificationSettings) {
    self.init(authorizationStatus: rawValue.authorizationStatus)
  }
}

extension UserNotificationClient {
  fileprivate class Delegate: NSObject, UNUserNotificationCenterDelegate {
    let continuation: AsyncStream<UserNotificationClient.DelegateEvent>.Continuation
    
    init(continuation: AsyncStream<UserNotificationClient.DelegateEvent>.Continuation) {
      self.continuation = continuation
    }
    
    func userNotificationCenter(
      _ center: UNUserNotificationCenter,
      didReceive response: UNNotificationResponse,
      withCompletionHandler completionHandler: @escaping () -> Void
    ) {
      self.continuation.yield(
        .didReceiveResponse(.init(rawValue: response)) {
          Task { @MainActor in
            completionHandler()
          }
        }
      )
    }
    
    func userNotificationCenter(
      _ center: UNUserNotificationCenter,
      openSettingsFor notification: UNNotification?
    ) {
      self.continuation.yield(
        .openSettingsForNotification(notification.map(Notification.init(rawValue:)))
      )
    }
    
    func userNotificationCenter(
      _ center: UNUserNotificationCenter,
      willPresent notification: UNNotification,
      withCompletionHandler completionHandler:
      @escaping (UNNotificationPresentationOptions) -> Void
    ) {
      self.continuation.yield(
        .willPresentNotification(.init(rawValue: notification)) { options in
          Task { @MainActor in
            completionHandler(options)
          }
        }
      )
    }
  }
}
