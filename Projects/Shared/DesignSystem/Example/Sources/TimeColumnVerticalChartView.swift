//
//  TimeColumnVerticalChartView.swift
//  DesignSystemExample
//
//  Created by 김지현 on 7/27/25.
//  Copyright © 2025 PomoNyang. All rights reserved.
//

import Foundation
import Utils

/** 집중추세 api response
"weeklyFocusTimeTrend": {
  "startDate": "2024-04-01",
  "endDate": "2024-04-07",
  "dateToFocusTimeStatistics": [
    {
      "date": "2024-04-01",
      "totalFocusTime": "PT30M"
    }
  ]
}
 */

// MARK: - 모델

import Foundation

struct WeeklyFocusTimeTrend { // Response  Model
  let startDate: Date // "2024-04-01"
  let endDate: Date // "2024-04-07"
  let dateToFocusTimeStatistics: [DateToFocusTimeStatistics]

  static let exampleResponse: Self = {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd"
    dateFormatter.timeZone = TimeZone(identifier: "UTC")

    let startDate: Date = dateFormatter.date(from: "2024-04-01")!
    let endDate: Date = dateFormatter.date(from: "2024-04-07")!

    return .init(
      startDate: startDate,
      endDate: endDate,
      dateToFocusTimeStatistics: [
        .init(date: dateFormatter.date(from: "2024-04-01")!,
              totalFocusTime: "PT30M"),
        .init(date: dateFormatter.date(from: "2024-04-02")!,
              totalFocusTime: "PT1H"),
        .init(date: dateFormatter.date(from: "2024-04-03")!,
              totalFocusTime: "PT2H"),
        .init(date: dateFormatter.date(from: "2024-04-04")!,
              totalFocusTime: "PT3H"),
        .init(date: dateFormatter.date(from: "2024-04-05")!,
              totalFocusTime: "PT4H"),
        .init(date: dateFormatter.date(from: "2024-04-06")!,
              totalFocusTime: "PT1M"),
        .init(date: dateFormatter.date(from: "2024-04-07")!,
              totalFocusTime: "PT0M")
      ])
  }()
}

struct DateToFocusTimeStatistics { // Response Model
  let date: Date // "2024-04-01"
  let totalFocusTime: String // "PT30M", "PT1H", ...
}

extension DateToFocusTimeStatistics: ChartDatable {
  var title: String {
    return date.toString(format: "mm/dd")
  }

  var value: Int {
    return DateComponents.durationFrom8601String(totalFocusTime)?.totalMinutes ?? 0
  }

  var id: String {
    return UUID().uuidString
  }
}


// MARK: - 차트 데이터 인터페이스

protocol ChartDatable: Identifiable {
  var title: String { get } // x축 타이틀
  var value: Int { get } // 높이값 (예: 30분 -> 30, 2시간 -> 120)
}

// MARK: - date extension

extension Date {
  func toString(format: String) -> String {
    let formatter = DateFormatter()
    formatter.dateFormat = format
    return formatter.string(from: self)
  }
}


// MARK: - 그래프 UI

import SwiftUI

struct TimeColumnVerticalChartView<ColumnData: ChartDatable>: View {
  let dataList: [ColumnData]
  let selectedData: ColumnData? // 선택한 거 하이라이트 해야함

  var body: some View {
    // 약간 요런느낌
    Chart {
      ForEach(dataList) { data in
        BarMark(
          x: .value(data.title, data.value),
          y: .value(data.title, data.value)
        )
      }
    }
  }
}
