//
//  CategoryRankingSection.swift
//  StatisticsFeature
//
//  Created by devMinseok on 8/7/25.
//  Copyright © 2025 PomoNyang. All rights reserved.
//

import SwiftUI
import DesignSystem
import PomodoroServiceInterface
import Utils

struct CategoryRankingSection: View {
  let info: StatisticsCategoryRanking

  var body: some View {
    VStack(spacing: .zero) {
      HStack(spacing: Alias.Spacing.small) {
        Text("카테고리 랭킹")
          .font(Typography.header4)
          .foregroundStyle(Alias.Color.Text.primary)
        Text("\(info.startDate.toString(format: .월일)) - \(info.endDate.toString(format: .월일))")
          .font(Typography.subBodyR)
          .foregroundStyle(Alias.Color.Text.tertiary)
      }
      .frame(maxWidth: .infinity, alignment: .leading)
      .padding(Alias.Spacing.xLarge)

      if info.rankingItems.isEmpty {
        HStack(alignment: .center, spacing: .zero) {
          Text("집중한 기록이 없어요")
            .foregroundStyle(Alias.Color.Text.disabled)
            .frame(maxWidth: .infinity, alignment: .leading)
          DesignSystemAsset.Image.bubbleEllipsesMono.swiftUIImage
            .renderingMode(.template)
            .resizable()
            .foregroundColor(Alias.Color.Icon.disabled)
            .frame(width: 48, height: 48)
        }
        .frame(height: 54)
        .padding(Alias.Spacing.xxLarge)
        .background {
          RoundedRectangle(cornerRadius:  Alias.BorderRadius.small)
            .fill(Alias.Color.Background.secondary)
        }
        .padding([.horizontal, .bottom], Alias.Spacing.xLarge)
      } else {
        VStack(spacing: 16) {
          ForEach(Array(info.rankingItems.enumerated()), id: \.offset) { _, item in
            HStack(spacing: 10) {
              Group {
                switch item.rank {
                case 1:
                  DesignSystemAsset.Image.crown1.swiftUIImage
                    .resizable()
                case 2:
                  DesignSystemAsset.Image.crown2.swiftUIImage
                    .resizable()
                case 3:
                  DesignSystemAsset.Image.crown3.swiftUIImage
                    .resizable()
                default:
                  DesignSystemAsset.Image.crown3.swiftUIImage
                    .resizable()
                }
              }
              .frame(width: 28, height: 28)
              Text(item.category.title)
                .font(Typography.bodySB)
                .foregroundStyle(Alias.Color.Text.primary)
                .frame(maxWidth: .infinity, alignment: .leading)
              Text(item.totalFocusTime.iso8601DurationToText(units: [.hour, .minute]))
                .font(Typography.bodyR)
                .foregroundStyle(Alias.Color.Text.tertiary)
            }
          }
        }
        .padding(Alias.Spacing.large)
        .background {
          RoundedRectangle(cornerRadius:  Alias.BorderRadius.small)
            .fill(Global.Color.white)
        }
        .padding([.horizontal, .bottom], Alias.Spacing.xLarge)
      }
    }
  }
}
