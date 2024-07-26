//
//  LocalPushNotificationContent.swift
//  PushService
//
//  Created by devMinseok on 7/24/24.
//  Copyright © 2024 PomoNyang. All rights reserved.
//

import Foundation

public enum LocalPushNotificationContent {
  case test
  
  public var title: String {
    switch self {
    case .test:
      return "테스트 집중"
    }
  }
  
  public var body: String {
    switch self {
    case .test:
      return "\(10)시 까지 집중해봐요!"
    }
  }
  
  public var identifier: String {
    switch self {
    case .test:
      return "group1"
    }
  }
}
