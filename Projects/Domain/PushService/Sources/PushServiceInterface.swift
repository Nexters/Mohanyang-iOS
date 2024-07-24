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

public func getPushNotificationContent(from userInfo: [AnyHashable: Any]) -> PushNotificationContent? {
  guard let data = try? JSONSerialization.data(withJSONObject: userInfo) else {
    return nil
  }
  let pushNotiContent = try? JSONDecoder().decode(PushNotificationContent.self, from: data)
  return pushNotiContent
}

public func scheduleNotification(
  userNotificationClient: UserNotificationClient,
  contentType: LocalPushNotificationContent,
  trigger: UNNotificationTrigger
) async throws -> Void {
  let content = UNMutableNotificationContent()
  content.title = contentType.title
  content.body = contentType.body
  content.sound = UNNotificationSound.default
  let request = UNNotificationRequest(
    identifier: contentType.identifier,
    content: content,
    trigger: trigger
  )
  return try await userNotificationClient.add(request)
}