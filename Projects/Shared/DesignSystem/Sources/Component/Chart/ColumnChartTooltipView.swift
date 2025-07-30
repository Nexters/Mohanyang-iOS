//
//  ColumnChartTooltipView.swift
//  DesignSystem
//
//  Created by 김지현 on 7/29/25.
//  Copyright © 2025 PomoNyang. All rights reserved.
//

import SwiftUI
import Utils

struct ColumnChartTooltipView: View {
  var title: String
  let position: CGRect

  private func calculateYPosition() -> CGFloat {
    let lineCount = title.components(separatedBy: "\n").count
    let offset = lineCount > 1 ? 36.0 : 24.0
    return position.minY - offset
  }
  
  var body: some View {
    VStack(spacing: 0) {
      Text(title)
        .multilineTextAlignment(.center)
        .foregroundStyle(Global.Color.white)
        .font(Typography.bodySB)
        .fixedSize(horizontal: true, vertical: true)
        .lineLimit(nil)
        .padding(.horizontal, Alias.Spacing.small)
        .padding(.vertical, Alias.Spacing.xSmall)
        .background(
          RoundedRectangle(cornerRadius: Alias.BorderRadius.xxSmall)
            .fill(Alias.Color.Icon.primary)
        )

      Triangle(direction: .down, color: Alias.Color.Icon.primary)
        .frame(width: 10, height: 8)
    }
    .position(x: position.midX, y: calculateYPosition())
    .ignoresSafeArea()
  }
}
