//
//  TooltipView.swift
//  DesignSystem
//
//  Created by devMinseok on 8/9/24.
//  Copyright © 2024 PomoNyang. All rights reserved.
//

import SwiftUI

struct TooltipView<Content: Tooltip>: View {
  let content: Content
  let position: CGRect
  
  var positionY: CGFloat {
    switch content.direction {
    case .up:
      return position.maxY + 32 + content.padding
    case .down:
      return position.minY - 32 - content.padding
    }
  }
  
  var body: some View {
    ZStack {
      content.title
        .foregroundStyle(content.color.foregroundColor)
        .font(Typography.bodySB)
        .padding(.horizontal, Alias.Spacing.large)
        .background(
          RoundedRectangle(cornerRadius: Alias.BorderRadius.xSmall)
            .fill(content.color.backgroundColor)
            .frame(height: 46)
        )
      Triangle(direction: content.direction == .down ? .down : .up, color: content.color.backgroundColor)
        .frame(width: 14, height: 9)
        .padding(content.direction == .down ? .top : .bottom, 55)
    }
    .position(x: position.midX, y: positionY)
    .ignoresSafeArea()
    .background(
      Global.Color.black.opacity(content.dimEnabled ? Global.Opacity._50d : 0.0)
        .mask(
          ExcludeRoundedRectMask(
            excludedRect: position,
            cornerRadius: content.targetCornerRadius ?? .zero
          )
        )
    )
  }
}
