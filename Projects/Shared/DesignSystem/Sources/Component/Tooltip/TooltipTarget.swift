//
//  TooltipTarget.swift
//  DesignSystem
//
//  Created by devMinseok on 8/9/24.
//  Copyright © 2024 PomoNyang. All rights reserved.
//

import SwiftUI

struct TooltipTarget: View {
  let identifier: AnyHashable
  
  var body: some View {
    GeometryReader { geometry in
      Color.clear
        .preference(
          key: FrameMeasurePreferenceKey.self,
          value: [identifier: geometry.frame(in: .global)]
        )
    }
  }
}

extension View {
  public func setTooltipTarget(tooltip: some Tooltip) -> some View {
    return self
      .background(
        TooltipTarget(identifier: tooltip)
      )
  }
  
  public func tooltipDestination(tooltip: Binding<(some Tooltip)?>) -> some View {
    return self
      .overlayWithOnPreferenceChange(FrameMeasurePreferenceKey.self) { value in
        if let content = tooltip.wrappedValue, let position = value[content] {
          TooltipView(content: content, position: position)
            .transition(.opacity.animation(.easeInOut))
            .onTapGesture {
              tooltip.wrappedValue = nil
            }
        }
      }
  }
}
