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

  var body: some View {
    VStack(spacing: 0) {
      Text(title)
        .lineLimit(2)
        .foregroundStyle(Global.Color.white)
        .font(Typography.bodySB)
        .padding(.horizontal, Alias.Spacing.small)
        .background(
          RoundedRectangle(cornerRadius: Alias.BorderRadius.small)
            .fill(Alias.Color.Icon.primary)
        )
      Triangle(direction: .down, color: Alias.Color.Icon.primary)
        .frame(width: 10, height: 8)
        .padding(.top , 55)
    }
    .position(x: position.midX, y: position.minY - 32 - 4)
    .ignoresSafeArea()
  }
}
