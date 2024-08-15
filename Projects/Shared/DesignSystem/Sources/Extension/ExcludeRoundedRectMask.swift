//
//  ExcludeRoundedRectMask.swift
//  DesignSystem
//
//  Created by devMinseok on 8/9/24.
//  Copyright © 2024 PomoNyang. All rights reserved.
//

import SwiftUI

public struct ExcludeRoundedRectMask: View {
  let excludedRect: CGRect
  let cornerRadius: CGFloat
  
  public init(
    excludedRect: CGRect,
    cornerRadius: CGFloat
  ) {
    self.excludedRect = excludedRect
    self.cornerRadius = cornerRadius
  }
  
  public var body: some View {
    GeometryReader { geometry in
      let fullRect = geometry.frame(in: .local)
      
      Path { path in
        path.addRect(fullRect)
        
        let roundedRect = RoundedRectangle(cornerRadius: cornerRadius)
          .path(in: excludedRect)
        path.addPath(roundedRect)
      }
      .fill(style: FillStyle(eoFill: true))
    }
    .ignoresSafeArea()
  }
}
