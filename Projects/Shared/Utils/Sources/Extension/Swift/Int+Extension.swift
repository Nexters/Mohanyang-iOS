//
//  Int+Extension.swift
//  Utils
//
//  Created by devMinseok on 8/23/24.
//  Copyright © 2024 PomoNyang. All rights reserved.
//

import Foundation

extension Int {
  public var timeInterval: TimeInterval {
    return .init(floatLiteral: Double(self))
  }
}
