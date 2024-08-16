//
//  TooltipTarget.swift
//  DesignSystem
//
//  Created by devMinseok on 8/9/24.
//  Copyright © 2024 PomoNyang. All rights reserved.
//

import SwiftUI

import Utils

struct TooltipTarget: View {
  let identifier: AnyHashable
  
  var body: some View {
    GeometryReader { geometry in
      Color.clear
        .preference(
          key: TooltipFramePreferenceKey.self,
          value: [identifier: geometry.frame(in: .global)]
        )
    }
  }
}

extension View {
  public func setTooltipTarget<T: Tooltip>(tooltip: T.Type) -> some View {
    return self
      .background(
        TooltipTarget(identifier: ObjectIdentifier(tooltip))
      )
  }
  
  public func tooltipDestination<T: Tooltip>(tooltip: Binding<T?>) -> some View {
    return self
      .overlayWithOnPreferenceChange(TooltipFramePreferenceKey.self) { value in
        if let content = tooltip.wrappedValue, let position = value[ObjectIdentifier(type(of: content))] {
          TooltipView(content: content, position: position)
            .transition(.opacity.animation(.easeInOut))
            .onTapGesture {
              tooltip.wrappedValue = nil
            }
        }
      }
  }
}
