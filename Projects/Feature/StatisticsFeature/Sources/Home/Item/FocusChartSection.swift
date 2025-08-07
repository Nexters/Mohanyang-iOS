//
//  FocusChartSection.swift
//  StatisticsFeature
//
//  Created by devMinseok on 8/7/25.
//  Copyright © 2025 PomoNyang. All rights reserved.
//

import SwiftUI
import DesignSystem
import PomodoroServiceInterface

struct FocusChartSection: View {
  @State var selectedData: StatisticsFocusTimeTrendItem?
  let info: StatisticsFocusTimeTrend
  
  var body: some View {
    VStack(spacing: .zero) {
      Text("집중 추세")
        .font(Typography.header4)
        .foregroundStyle(Alias.Color.Text.primary)
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(Alias.Spacing.xLarge)
      VStack(alignment: .leading, spacing: 10) {
        Text(info.totalFocusTime.iso8601DurationToText(units: [.hour, .minute]))
          .font(Typography.header4)
          .foregroundStyle(Alias.Color.Text.secondary)
        TimeColumnVerticalChartView(
          dataList: info.dateToFocusTimeStatistics,
          selectedData: $selectedData
        )
      }
      .padding(Alias.Spacing.large)
      .background {
        RoundedRectangle(cornerRadius: Alias.BorderRadius.small)
          .fill(Global.Color.white)
      }
      .padding([.horizontal, .bottom], Alias.Spacing.xLarge)
    }
  }
}

extension StatisticsFocusTimeTrendItem: @retroactive ChartDatable {
  public var title: String {
    return date.toString(format: .Md)
  }
  
  public var value: Int {
    return DateComponents.durationFrom8601String(totalFocusTime)?.totalMinutes ?? 0
  }
  
  public var id: UUID {
    return UUID()
  }
}
