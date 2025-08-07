//
//  FocusHistorySection.swift
//  StatisticsFeature
//
//  Created by devMinseok on 8/7/25.
//  Copyright © 2025 PomoNyang. All rights reserved.
//

import SwiftUI
import DesignSystem
import PomodoroServiceInterface

struct FocusHistorySection: View {
  let histories: [StatisticsFocusTime]
  @State private var currentPage: Int = 0
  let pageSize: Int = 10

  private var displayedCount: Int {
    min(histories.count, 3 + currentPage * pageSize)
  }

  var body: some View {
    Group {
      if !histories.isEmpty {
        VStack(alignment: .center, spacing: .zero) {
          HStack(spacing: Alias.Spacing.xSmall) {
            Text("집중 기록")
              .foregroundStyle(Alias.Color.Text.primary)
            Text("\(histories.count)")
              .foregroundStyle(Alias.Color.Background.accent1)
          }
          .font(Typography.header4)
          .frame(maxWidth: .infinity, alignment: .leading)
          .padding(Alias.Spacing.xLarge)

          VStack(spacing: .zero) {
            ForEach(Array(histories.prefix(displayedCount))) { history in
              FocusHistorySectionListItem(info: history)
            }
          }
          .padding(.horizontal, Alias.Spacing.xLarge)

          if displayedCount < histories.count {
            Button(
              title: "더 보기",
              rightIcon: {
                DesignSystemAsset.Image.chevronDown.swiftUIImage
                  .re(size: 24, color: Alias.Color.Icon.tertiary)
              },
              action: {
                currentPage += 1
              }
            )
            .buttonStyle(.text(level: .secondary, size: .medium))
            .padding(.bottom, Alias.Spacing.xLarge)
          }
        }
      }
    }
    .onChange(of: histories) { _, _ in
      currentPage = 0
    }
  }
}
