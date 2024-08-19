//
//  LocalPushNotificationContent.swift
//  PushService
//
//  Created by devMinseok on 7/24/24.
//  Copyright © 2024 PomoNyang. All rights reserved.
//

import Foundation
import CatServiceInterface

public enum LocalPushNotificationContent {
  case focus(AnyCat)
  case rest(AnyCat)
  case disturb(AnyCat)

  public var title: String {
    return "모하냥"
  }
  
  public var body: String {
    switch self {
    case .focus(let cat):
      return cat.focusEndPushTitle
    case .rest(let cat):
      return cat.restEndPushTitle
    case .disturb(let cat):
      return cat.disturbPushTitle
    }
  }
  
  public var identifier: String {
    switch self {
    case .focus:
      return "focus"
    case .rest:
      return "rest"
    case .disturb:
      return "disturb"
    }
  }
}
