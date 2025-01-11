//
//  PushServiceInterface.swift
//  PushService
//
//  Created by devMinseok on 7/22/24.
//  Copyright © 2024 PomoNyang. All rights reserved.
//

import Foundation
import UserNotifications

import UserNotificationClientInterface

public func scheduleNotification(
  userNotificationClient: UserNotificationClient,
  contentType: LocalPushNotiContent,
  trigger: UNNotificationTrigger
) async throws -> Void {
  let content = UNMutableNotificationContent()
  content.title = contentType.title
  content.subtitle = contentType.title
  content.body = contentType.body
  content.sound = contentType.sound
  let request = UNNotificationRequest(
    identifier: contentType.identifier,
    content: content,
    trigger: trigger
  )
  return try await userNotificationClient.add(request)
}

public func removePendingNotification(
  userNotificationClient: UserNotificationClient,
  identifier: [String]
) async -> Void {
  await userNotificationClient.removePendingNotificationRequestsWithIdentifiers(identifier)
}
