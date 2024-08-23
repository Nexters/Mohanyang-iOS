//
//  OffsetReader.swift
//  OnboardingFeature
//
//  Created by 김지현 on 8/14/24.
//  Copyright © 2024 PomoNyang. All rights reserved.
//

import SwiftUI

struct OffsetKey: PreferenceKey {
  static var defaultValue: CGFloat = .zero
  static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
    value = nextValue()
  }
}

extension View {
  @ViewBuilder
  func offsetX(_ addObserver: Bool, completion: @escaping (CGFloat) -> Void) -> some View {
    self
      .frame(maxWidth: .infinity)
      .overlay {
        if addObserver {
          GeometryReader { geometry in
            let minX = geometry.frame(in: .global).minX
            Color.clear
              .preference(key: OffsetKey.self, value: minX)
              .onPreferenceChange(OffsetKey.self, perform: completion)
          }
        }
      }
  }
}
