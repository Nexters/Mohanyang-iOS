//
//  LocalPushNotiContent.swift
//  PushService
//
//  Created by devMinseok on 7/24/24.
//  Copyright © 2024 PomoNyang. All rights reserved.
//

import CatServiceInterface

public enum LocalPushNotiContent {
  case focusEnd(SomeCat)
  case restEnd(SomeCat)
  case disturb(SomeCat)

  public var title: String {
    return "모하냥"
  }
  
  public var body: String {
    switch self {
    case .focusEnd(let cat):
      return cat.focusEndPushTitle
      
    case .restEnd(let cat):
      return cat.restEndPushTitle
      
    case .disturb(let cat):
      return cat.disturbPushTitle
    }
  }
  
  public var identifier: String {
    switch self {
    case .focusEnd:
      return "focusEnd"
      
    case .restEnd:
      return "restEnd"
      
    case .disturb:
      return "disturb"
    }
  }
}
