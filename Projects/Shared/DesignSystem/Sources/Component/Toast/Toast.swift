//
//  Toast.swift
//  DesignSystem
//
//  Created by devMinseok on 8/16/24.
//  Copyright © 2024 PomoNyang. All rights reserved.
//

import SwiftUI

public protocol Toast: Equatable {
  var message: String { get }
  var image: Image? { get }
  var hideAutomatically: Bool { get }
}

public struct DefaultToast: Toast {
  public let message: String
  public let image: Image?
  public let hideAutomatically: Bool
  
  public init(
    message: String,
    image: Image
  ) {
    self.message = message
    self.image = image
    hideAutomatically = true
  }
}
