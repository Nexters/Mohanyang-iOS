//
//  StatisticsHomeView.swift
//  StatisticsFeature
//
//  Created by devMinseok on 7/7/25.
//  Copyright © 2025 PomoNyang. All rights reserved.
//

import SwiftUI

import DesignSystem
import PomodoroServiceInterface

import ComposableArchitecture

public struct StatisticsHomeView: View {
  @Bindable var store: StoreOf<StatisticsHomeCore>

  public init(store: StoreOf<StatisticsHomeCore>) {
    self.store = store
  }

  public var body: some View {
    NavigationContainer(
      title: titleView,
      leading: {
        if store.isPrevAvailable {
          Button(icon: DesignSystemAsset.Image._24ChevronLeftPrimary.swiftUIImage) {
            store.send(.prevDateButtonTapped)
          }
          .buttonStyle(.icon(isFilled: false, level: .primary))
        }
      },
      trailing: {
        if store.isNextAvailable {
          Button(icon: DesignSystemAsset.Image._24ChevronRightPrimary.swiftUIImage) {
            store.send(.nextDateButtonTapped)
          }
          .buttonStyle(.icon(isFilled: false, level: .primary))
        }
      },
      style: .navigation
    ) {
      ScrollView(.vertical) {
        VStack(spacing: Alias.Spacing.xLarge) {
          TotalFocusTimeSection(
            totalFocusTime: store.statisticsOfDate?.totalFocusTime ?? "",
            histories: store.statisticsOfDate?.focusTimes ?? []
          )
          FocusHistorySection(histories: store.statisticsOfDate?.focusTimes ?? [])
          if let info = store.statisticsOfDate?.weeklyFocusTimeTrend {
            FocusChartSection(info: info)
          }
          if let info = store.statisticsOfDate?.categoryRanking {
            CategoryRankingSection(info: info)
          }
        }
      }
      .padding(.bottom, 60)
    }
    .background(Global.Color.gray50)
    .onAppear {
      store.send(.onAppear)
    }
  }

  var titleView: some View {
    HStack(spacing: Alias.Spacing.xSmall) {
      Text(store.selectedDate.toString(format: .월일))
        .font(Typography.header5)
        .foregroundStyle(Alias.Color.Text.primary)
      Button {
      } icon: {
        DesignSystemAsset.Image.chevronDown.swiftUIImage
          .re(size: 16, color: Alias.Color.Icon.tertiary)
      }
      .buttonStyle(.icon(isFilled: true, level: .secondary))
    }
    .padding(5)
    .background(Global.Color.gray50)
    .allowsHitTesting(false)
    .background {
      DatePicker(
        selection: $store.selectedDate.sending(\.calendarDateSelected),
        in: (store.userInfo?.createdAt ?? Date())...Date(),
        displayedComponents: .date
      ) {
      }
      .datePickerStyle(.compact)
    }
  }
}
