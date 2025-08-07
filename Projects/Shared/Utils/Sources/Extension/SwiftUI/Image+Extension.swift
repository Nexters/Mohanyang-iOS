//
//  Image+Extension.swift
//  Utils
//
//  Created by devMinseok on 8/2/25.
//  Copyright © 2025 PomoNyang. All rights reserved.
//

import SwiftUI

extension Image {
  /// length of one side of a square
  public func resize(_ size: CGFloat) -> some View {
    return self
      .resizable()
      .frame(width: size, height: size)
  }
  
  public func recolor(_ color: Color) -> some View {
    return self
      .renderingMode(.template)
      .foregroundStyle(color)
  }
  
  public func re(size: CGFloat, color: Color) -> some View {
    return self
      .resizable()
      .renderingMode(.template)
      .frame(width: size, height: size)
      .foregroundStyle(color)
  }
}
