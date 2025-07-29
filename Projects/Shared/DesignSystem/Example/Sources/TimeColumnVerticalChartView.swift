//
//  TimeColumnVerticalChartView.swift
//  DesignSystemExample
//
//  Created by 김지현 on 7/27/25.
//  Copyright © 2025 PomoNyang. All rights reserved.
//

import Foundation
import Utils
import DesignSystem

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
              totalFocusTime: "PT29M"),
        .init(date: dateFormatter.date(from: "2024-04-03")!,
              totalFocusTime: "PT10M"),
        .init(date: dateFormatter.date(from: "2024-04-04")!,
              totalFocusTime: "PT20M"),
        .init(date: dateFormatter.date(from: "2024-04-05")!,
              totalFocusTime: "PT1H"),
        .init(date: dateFormatter.date(from: "2024-04-06")!,
              totalFocusTime: "PT47M"),
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
    return date.toString(format: "M/d")
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


// MARK: - Y축 라벨 구조체
struct YAxisLabel {
  let value: Int // 분 단위 값
  let title: String // 표시될 문자열
  
  init(value: Int, title: String) {
    self.value = value
    self.title = title
  }
  
  init(hour: Int) {
    self.value = hour * 60
    self.title = "\(hour)h"
  }
  
  init(minute: Int) {
    self.value = minute
    self.title = "\(minute)m"
  }
}

// MARK: - 그래프 UI

import SwiftUI

struct TimeColumnVerticalChartView<ColumnData: ChartDatable>: View {
  let dataList: [ColumnData]
  let selectedData: ColumnData? // 선택한 거 하이라이트 해야함
  
  var body: some View {
    Chart(maxValue: maxValue, yAxisLabels: yAxisLabels) {
      ForEach(dataList) { data in
        BarMark(title: data.title, ratio: calculateRatio(value: data.value))
        .highlighted(data.id == selectedData?.id)
      }
    }
    .padding(.horizontal, 40)
  }
  
  // 최대값 계산
  private var maxValue: Int {
    let max = dataList.map { $0.value }.max() ?? 0
    return max > 0 ? max : 10 // 기본값 설정
  }
  
  // Y축 라벨 계산
  private var yAxisLabels: [YAxisLabel] {
    let maxMinutes = maxValue // 최대값 (분 단위)

    if maxMinutes == 0 {
      return [YAxisLabel(minute: 10), YAxisLabel(minute: 0)]
    }
    else if maxMinutes < 60 { // 1시간 미만
      return [YAxisLabel(minute: 60), YAxisLabel(minute: 45), YAxisLabel(minute: 30), YAxisLabel(minute: 15), YAxisLabel(minute: 0)]
    }
    else if maxMinutes >= 60 && maxMinutes < 300 { // 1~5시간
      // 시간대에 따라 눈금 결정
      if maxMinutes < 120 { // 1~2시간
        return [YAxisLabel(hour: 2), YAxisLabel(hour: 1), YAxisLabel(minute: 0)]
      }
      else if maxMinutes < 180 { // 2~3시간
        return [YAxisLabel(hour: 3), YAxisLabel(hour: 2), YAxisLabel(hour: 1), YAxisLabel(minute: 0)]
      }
      else if maxMinutes < 240 { // 3~4시간
        return [YAxisLabel(hour: 4), YAxisLabel(hour: 3), YAxisLabel(hour: 2), YAxisLabel(hour: 1), YAxisLabel(minute: 0)]
      }
      else { // 4~5시간
        return [YAxisLabel(hour: 5), YAxisLabel(hour: 4), YAxisLabel(hour: 3), YAxisLabel(hour: 2), YAxisLabel(hour: 1), YAxisLabel(minute: 0)]
      }
    }
    else if maxMinutes >= 300 && maxMinutes < 480 { // 5~8시간
      return [YAxisLabel(hour: 8), YAxisLabel(hour: 6), YAxisLabel(hour: 4), YAxisLabel(hour: 2), YAxisLabel(minute: 0)]
    }
    else if maxMinutes >= 480 && maxMinutes < 1200 { // 8~20시간
      if maxMinutes < 600 { // 8~10시간
        return [YAxisLabel(hour: 10), YAxisLabel(hour: 5), YAxisLabel(minute: 0)]
      }
      else if maxMinutes < 900 { // 10~15시간
        return [YAxisLabel(hour: 15), YAxisLabel(hour: 10), YAxisLabel(hour: 5), YAxisLabel(minute: 0)]
      }
      else { // 15~20시간
        return [YAxisLabel(hour: 20), YAxisLabel(hour: 15), YAxisLabel(hour: 10), YAxisLabel(hour: 5), YAxisLabel(minute: 0)]
      }
    }
    else { // 20~24시간
      return [YAxisLabel(hour: 24), YAxisLabel(hour: 18), YAxisLabel(hour: 12), YAxisLabel(hour: 6), YAxisLabel(minute: 0)]
    }
  }
  
  // Y축 최대값 기준으로 비율 계산
  private func calculateRatio(value: Int) -> CGFloat {
    let yAxisMaxValue = yAxisLabels.first?.value ?? maxValue
    return CGFloat(value) / CGFloat(yAxisMaxValue)
  }
}

// MARK: - 차트 구현

struct Chart<Content: View>: View {
  var maxValue: Int
  let content: Content
  let yAxisLabels: [YAxisLabel]

  private var barSpacing: CGFloat = 16
  private var padding: CGFloat = 12
  
  init(maxValue: Int, yAxisLabels: [YAxisLabel], @ViewBuilder content: () -> Content) {
    self.maxValue = maxValue
    self.yAxisLabels = yAxisLabels
    self.content = content()
  }
  
  var body: some View {
    ZStack {
      YAxisGridLines(labels: yAxisLabels.map { $0.title })
        .padding(.bottom, 12)

      HStack(spacing: 0) {
        content
      }
      .padding(.top, 8)
      .padding(.trailing, 30)
    }
    .frame(height: 188)
  }
  
  // 그래프 높이에 사용할 최대 값 (배열의 첫 번째 값)
  var yAxisMaxValue: Int {
    return yAxisLabels.first?.value ?? maxValue
  }
}

// MARK: - 바 마크 뷰
struct BarMark: View {
  var title: String
  var ratio: CGFloat
  private var isHighlighted: Bool = false
  private var color: Color {
    if isHighlighted {
      return Alias.Color.Background.accent1
    } else {
      return ratio == 0 ? Alias.Color.Icon.disabled : Alias.Color.Icon.secondary
    }
  }

  init(title: String, ratio: CGFloat) {
    self.title = title
    self.ratio = ratio
  }

  var body: some View {
    VStack(spacing: 0) {
      Spacer()

      // 막대 부분
      Rectangle()
        .fill(color)
        .frame(height: calculateBarHeight())
        .cornerRadius(8, corners: [.topLeft, .topRight])
        .padding(.horizontal, 8)

      // 0 위치 경계선
      Rectangle()
        .fill(Alias.Color.Icon.disabled)
        .frame(height: 1)

      Text(title)
        .font(Typography.captionR)
        .foregroundStyle(Alias.Color.Text.tertiary)
        .frame(height: 16)
        .padding(.top, 4)
    }
  }

  private func calculateBarHeight() -> CGFloat {
    
    let height = CGFloat(ratio) * 160
    print(ratio, height)
    return max(height, 4) // 최소 높이 설정
  }

  func highlighted(_ isHighlighted: Bool) -> BarMark {
    var copy = self
    copy.isHighlighted = isHighlighted
    return copy
  }
}

// MARK: - Y축 그리드라인
struct YAxisGridLines: View {
  let labels: [String]
  
  var body: some View {
    VStack(spacing: 0) {
      ForEach(0 ..< labels.count, id: \.self) { index in
        HStack(spacing: 8) {
          Line()
            .stroke(style: StrokeStyle(lineWidth: 1, dash: index == labels.count - 1 ? [] : [5, 3]))
            .foregroundColor(Alias.Color.Icon.disabled)
            .frame(height: 1)

          Text(labels[index])
            .font(Typography.captionR)
            .foregroundStyle(Alias.Color.Text.tertiary)
            .frame(width: 22, alignment: .trailing)
        }
        if index < labels.count - 1 {
          Spacer()
        }
      }
    }
  }
}

struct Line: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: rect.width, y: 0))
        return path
    }
}
