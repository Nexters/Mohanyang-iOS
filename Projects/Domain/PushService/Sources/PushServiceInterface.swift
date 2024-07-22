//
//  PushServiceInterface.swift
//  PushService
//
//  Created by devMinseok on 7/22/24.
//  Copyright © 2024 PomoNyang. All rights reserved.
//

import Foundation

public func getPushNotificationContent(from userInfo: [AnyHashable: Any]) -> PushNotificationContent? {
  guard let data = try? JSONSerialization.data(withJSONObject: userInfo) else {
    return nil
  }
  let pushNotiContent = try? JSONDecoder().decode(PushNotificationContent.self, from: data)
  return pushNotiContent
}
