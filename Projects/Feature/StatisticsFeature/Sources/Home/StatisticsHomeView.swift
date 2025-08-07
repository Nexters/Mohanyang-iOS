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
          FocusGraphSection()
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
        selection: $store.selectedDate.sending(\.setSelectedDate),
        in: (store.userInfo?.createdAt ?? Date())...Date(),
        displayedComponents: .date
      ) {
      }
      .datePickerStyle(.compact)
    }
  }
}


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

struct FocusHistorySection: View {
  let histories: [StatisticsFocusTime]
  
  var body: some View {
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
          ForEach(histories) { history in
            FocusHistorySectionListItem(info: history)
          }
        }
        .padding(.horizontal, Alias.Spacing.xLarge)
        
        Button(
          title: "더 보기",
          rightIcon: {
            DesignSystemAsset.Image.chevronDown.swiftUIImage
              .resizable()
              .frame(width: 16, height: 16)
          },
          action: { /*action*/ }
        )
        .buttonStyle(.text(level: .secondary, size: .medium))
        .padding(.bottom, Alias.Spacing.xLarge)
      }
    }
  }
}

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
            Text(info.getTotalFocusTimeText(units: [.hour, .minute]))
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


struct FocusGraphSection: View {
  var body: some View {
    VStack(spacing: .zero) {
      Text("집중 추세")
        .font(Typography.header4)
        .foregroundStyle(Alias.Color.Text.primary)
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(Alias.Spacing.xLarge)
      
      RoundedRectangle(cornerRadius: Alias.BorderRadius.xSmall)
        .frame(height: 300)
        .padding([.horizontal, .bottom], Alias.Spacing.xLarge)
    }
  }
}


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
              Text(item.getTotalFocusTimeText(units: [.hour, .minute]))
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
