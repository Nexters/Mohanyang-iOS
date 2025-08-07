//
//  FocusHistorySectionListItem.swift
//  StatisticsFeature
//
//  Created by devMinseok on 8/7/25.
//  Copyright © 2025 PomoNyang. All rights reserved.
//

import SwiftUI
import DesignSystem
import PomodoroServiceInterface

struct FocusHistorySectionListItem: View {
  let info: StatisticsFocusTime

  var body: some View {
    HStack(alignment: .center, spacing: 4) {
      VStack(alignment: .center, spacing: 2) {
        Circle()
          .fill(Color.clear)
          .strokeBorder(Alias.Color.Icon.disabled, lineWidth: 2)
          .padding(2.5)
          .frame(width: 20, height: 20)
          .padding(.top, 1)
        DottedLine(.vertical, color: Alias.Color.Icon.disabled)
          .frame(width: 20, height: 104)
      }

      VStack(alignment: .leading, spacing: .zero) {
        Text("\(info.startedAt.toString(format: .HH_mm)) - \(info.doneAt.toString(format: .HH_mm))")
          .font(Typography.subBodyR)
          .foregroundStyle(Alias.Color.Text.tertiary)
          .frame(height: 20)

        HStack(alignment: .center, spacing: Alias.Spacing.large) {
          ZStack(alignment: .center) {
            RoundedRectangle(cornerRadius: Alias.BorderRadius.xSmall)
              .fill(Alias.Color.Background.primary)
              .frame(width: 56, height: 56)
            info.category?.iconType.image
              .resizable()
              .frame(width: 32, height: 32)
          }

          VStack(alignment: .leading, spacing: Alias.Spacing.xxSmall) {
            Text(info.category?.title ?? "")
              .font(Typography.header5)
              .foregroundStyle(Alias.Color.Text.primary)
            Text(info.totalFocusTime.iso8601DurationToText(units: [.hour, .minute]))
              .font(Typography.subBodyR)
              .foregroundStyle(Alias.Color.Text.secondary)
          }
          .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding(Alias.Spacing.large)
        .background {
          RoundedRectangle(cornerRadius: Alias.BorderRadius.small)
            .fill(Global.Color.white)
        }
        .padding(.vertical, Alias.Spacing.small)
        .frame(height: 104)
      }
    }
  }
}
