//
//  TimeItem.swift
//  HomeFeature
//
//  Created by devMinseok on 12/30/24.
//  Copyright © 2024 PomoNyang. All rights reserved.
//

import Foundation

public struct TimeItem: WheelPickerData {
  let minute: Int
  
  init(minute: Int) {
    self.minute = minute
  }
  
  public var id: Int {
    return minute
  }
  
  var title: String {
    return String(format: "%02d:00", minute)
  }
  
  var data: Int {
    return minute
  }
}
