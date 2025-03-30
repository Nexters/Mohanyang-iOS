//
//  Image+Resize.swift
//  Utils
//
//  Created by 김지현 on 3/30/25.
//  Copyright © 2025 PomoNyang. All rights reserved.
//

import SwiftUI

extension Image {
  /// length of one side of a square
  public func resize(_ length: CGFloat) -> some View {
    return self.resizable().frame(width: length, height: length)
  }
}
