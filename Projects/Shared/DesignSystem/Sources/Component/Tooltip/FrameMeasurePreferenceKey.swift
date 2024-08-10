//
//  FrameMeasurePreferenceKey.swift
//  DesignSystem
//
//  Created by devMinseok on 8/9/24.
//  Copyright © 2024 PomoNyang. All rights reserved.
//

import SwiftUI

struct FrameMeasurePreferenceKey: PreferenceKey {
  typealias Value = [AnyHashable: CGRect]
  
  static var defaultValue: Value = Value()
  
  static func reduce(value: inout Value, nextValue: () -> Value) {
    value.merge(nextValue()) { _, new in
      new
    }
  }
}
