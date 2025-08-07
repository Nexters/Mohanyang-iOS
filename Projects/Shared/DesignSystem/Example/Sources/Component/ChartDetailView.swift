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
  @State var selectedData: ExampleChartData?

  var body: some View {
    ScrollView {
      VStack {
        TimeColumnVerticalChartView(
          dataList: demoData,
          selectedData: $selectedData
        )
        .padding(.horizontal, 0)

        TimeColumnVerticalChartView(
          dataList: demoData,
          selectedData: $selectedData
        )
        .padding(.horizontal, 30)

        TimeColumnVerticalChartView(
          dataList: demoData,
          selectedData: $selectedData
        )
        .padding(.horizontal, 60)
      }
    }
  }
}

#Preview {
  ChartDetailView()
}


// MARK: - Example data

struct ExampleChartData: ChartDatable {
  let date: Date // "2024-04-01"
  let totalFocusTime: String // "PT30M", "PT1H", ...

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

var demoData: [ExampleChartData] = {
  let dateFormatter = DateFormatter()
  dateFormatter.dateFormat = "yyyy-MM-dd"
  return [
    .init(date: dateFormatter.date(from: "2024-04-01")!, totalFocusTime: "PT30M"),
    .init(date: dateFormatter.date(from: "2024-04-02")!, totalFocusTime: "PT29M"),
    .init(date: dateFormatter.date(from: "2024-04-03")!, totalFocusTime: "PT10M"),
    .init(date: dateFormatter.date(from: "2024-04-04")!, totalFocusTime: "PT20M"),
    .init(date: dateFormatter.date(from: "2024-04-05")!, totalFocusTime: "PT1H"),
    .init(date: dateFormatter.date(from: "2024-04-06")!, totalFocusTime: "PT1H47M"),
    .init(date: dateFormatter.date(from: "2024-04-07")!, totalFocusTime: "PT0M")
  ]
}()
