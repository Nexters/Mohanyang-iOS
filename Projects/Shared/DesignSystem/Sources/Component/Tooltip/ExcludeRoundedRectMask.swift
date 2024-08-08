//
//  ExcludeRoundedRectMask.swift
//  DesignSystem
//
//  Created by devMinseok on 8/9/24.
//  Copyright © 2024 PomoNyang. All rights reserved.
//

import SwiftUI

struct ExcludeRoundedRectMask: View {
  let excludedRect: CGRect
  let cornerRadius: CGFloat
  
  var body: some View {
    GeometryReader { geometry in
      let fullRect = geometry.frame(in: .local)
      
      Path { path in
        // 전체 영역
        path.addRect(fullRect)
        
        // 제외할 둥근 사각형
        let roundedRect = RoundedRectangle(cornerRadius: cornerRadius)
          .path(in: excludedRect)
        path.addPath(roundedRect)
      }
      .fill(style: FillStyle(eoFill: true)) // 외곽선 필 방식 사용
    }
    .ignoresSafeArea()
  }
}
