//
//  ChartDetailView.swift
//  DesignSystemExample
//
//  Created by 김지현 on 7/30/25.
//  Copyright © 2025 PomoNyang. All rights reserved.
//

import SwiftUI

import DesignSystem

struct ChartDetailView: View {

  var body: some View {
    VStack {
      Spacer()

      VStack {
        HStack {
          Text("총 5시간 55분")
            .font(Typography.header4)
            .foregroundStyle(Alias.Color.Text.secondary)
            .padding(.bottom, 10)

          Spacer()
        }

        TimeColumnVerticalChartView(
          dataList: WeeklyFocusTimeTrend.exampleResponse.dateToFocusTimeStatistics,
          selectedData: WeeklyFocusTimeTrend.exampleResponse.dateToFocusTimeStatistics.first
        )
      }
      .padding(16)
      .background(.white)
      .cornerRadius(16)

      Spacer()
    }
    .padding(.horizontal, 20)
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .background(Alias.Color.Background.primary)
  }
}

#Preview {
  InputFieldDetailView()
}
