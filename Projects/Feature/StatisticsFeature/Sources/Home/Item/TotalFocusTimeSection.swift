//
//  TotalFocusTimeSection.swift
//  StatisticsFeature
//
//  Created by devMinseok on 8/7/25.
//  Copyright © 2025 PomoNyang. All rights reserved.
//

import SwiftUI
import DesignSystem
import PomodoroServiceInterface

struct TotalFocusTimeSection: View {
  let totalFocusTime: String
  let histories: [StatisticsFocusTime]
  
  var totalFocusTimeText: String {
    guard let dateComponents = DateComponents.durationFrom8601String(totalFocusTime) else { return "" }
    let formatter = DateComponentsFormatter()
    formatter.unitsStyle = .full
    formatter.allowedUnits = [.hour, .minute]
    return formatter.string(from: dateComponents) ?? ""
  }
  
  var body: some View {
    VStack(spacing: .zero) {
      Text("총 집중시간")
        .font(Typography.header4)
        .foregroundStyle(Alias.Color.Text.primary)
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(Alias.Spacing.xLarge)
      
      HStack(alignment: .center, spacing: .zero) {
        if histories.isEmpty {
          Text("집중한 기록이 없어요")
            .foregroundStyle(Alias.Color.Text.disabled)
            .frame(maxWidth: .infinity, alignment: .leading)
          DesignSystemAsset.Image.bubbleEllipsesMono.swiftUIImage
            .renderingMode(.template)
            .resizable()
            .foregroundColor(Alias.Color.Icon.disabled)
            .frame(width: 48, height: 48)
        } else {
          VStack(alignment: .leading, spacing: Alias.Spacing.xSmall) {
            Text(totalFocusTimeText)
              .font(Typography.header3)
            Text("집중했어요!")
              .font(Typography.bodySB)
          }
          .foregroundStyle(Alias.Color.Text.inverse)
          .frame(maxWidth: .infinity, alignment: .leading)
          DesignSystemAsset.Image.fire.swiftUIImage
            .resizable()
            .frame(width: 48, height: 48)
        }
      }
      .frame(height: 54)
      .padding(Alias.Spacing.xxLarge)
      .background {
        RoundedRectangle(cornerRadius:  Alias.BorderRadius.small)
          .fill(histories.isEmpty ? Alias.Color.Background.secondary : Alias.Color.Background.accent1)
      }
      .padding([.horizontal, .bottom], Alias.Spacing.xLarge)
    }
  }
}
