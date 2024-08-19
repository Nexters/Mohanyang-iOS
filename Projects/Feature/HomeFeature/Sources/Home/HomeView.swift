//
//  HomeView.swift
//  HomeFeatureInterface
//
//  Created by devMinseok on 7/22/24.
//  Copyright © 2024 PomoNyang. All rights reserved.
//

import SwiftUI

import MyPageFeature
import DesignSystem
import Utils

import ComposableArchitecture

public struct HomeView: View {
  @Bindable var store: StoreOf<HomeCore>
  
  public init(store: StoreOf<HomeCore>) {
    self.store = store
  }
  
  public var body: some View {
    NavigationContainer(
      leading: {
        Spacer()
      },
      trailing: {
        Button(
          icon: DesignSystemAsset.Image._24MenuPrimary.swiftUIImage,
          action: {
            store.send(.mypageButtonTappd)
          }
        )
        .buttonStyle(.icon(isFilled: false, level: .primary))
      },
      style: .navigation
    ) {
      VStack(spacing: 40) {
        VStack(spacing: Alias.Spacing.xLarge) {
          Rectangle()
            .fill(Alias.Color.Background.secondary)
            .frame(width: 240, height: 240)
            .setTooltipTarget(tooltip: HomeCatDialogueTooltip.self)
          Text("치즈냥")
            .font(Typography.header4)
            .foregroundStyle(Alias.Color.Text.tertiary)
        }
        VStack(spacing: Alias.Spacing.medium) {
          Button(
            title: .init(store.selectedCategory?.title ?? ""),
            leftIcon: store.selectedCategory?.image
          ) {
            store.send(.categoryButtonTapped)
          }
          .buttonStyle(.box(level: .tertiary, size: .small))
          .setTooltipTarget(tooltip: HomeCategoryGuideTooltip.self)
          
          HStack(spacing: Alias.Spacing.medium) {
            HStack(spacing: Alias.Spacing.small) {
              Text("집중")
                .font(Typography.bodySB)
                .foregroundStyle(Global.Color.gray500)
              Text("\(store.selectedCategory?.focusTimeMinute ?? 0)분")
                .font(Typography.header3)
                .foregroundStyle(Alias.Color.Text.secondary)
            }
            .padding(Alias.Spacing.small)
            .onTapGesture {
              store.send(.focusTimeButtonTapped)
            }
            
            Rectangle()
              .fill(Global.Color.gray200)
              .frame(width: 2, height: Global.Dimension._20f)
            
            HStack(spacing: Alias.Spacing.small) {
              Text("휴식")
                .font(Typography.bodySB)
                .foregroundStyle(Global.Color.gray500)
              Text("\(store.selectedCategory?.restTimeMinute ?? 0)분")
                .font(Typography.header3)
                .foregroundStyle(Alias.Color.Text.secondary)
            }
            .padding(Alias.Spacing.small)
            .onTapGesture {
              store.send(.restTimeButtonTapped)
            }
          }
          .padding(.horizontal, 8)
          .padding(.vertical, 4)
          .setTooltipTarget(tooltip: HomeTimeGuideTooltip.self)
        }
        Button(
          icon: DesignSystemAsset.Image._32PlayPrimary.swiftUIImage,
          action: {
            store.send(.playButtonTapped)
          }
        )
        .buttonStyle(.round(level: .primary))
      }
    }
    .background(Global.Color.gray50)
    .tooltipDestination(tooltip: $store.homeCatTooltip.sending(\.setHomeCatTooltip))
    .tooltipDestination(tooltip: $store.homeCategoryGuideTooltip.sending(\.setHomeCategoryGuideTooltip))
    .tooltipDestination(tooltip: $store.homeTimeGuideTooltip.sending(\.setHomeTimeGuideTooltip))
    .bottomSheet(
      item: $store.scope(
        state: \.categorySelect,
        action: \.categorySelect
      )
    ) { store in
      CategorySelectView(store: store)
    }
    .fullScreenCover(
      item: $store.scope(
        state: \.timeSelect,
        action: \.timeSelect
      )
    ) { store in
      TimeSelectView(store: store)
    }
    .navigationDestination(
      item: $store.scope(
        state: \.myPage,
        action: \.myPage
      )
    ) { store in
      MyPageView(store: store)
    }
    .onLoad {
      store.send(.onLoad)
    }
    .onAppear {
      store.send(.onAppear)
    }
  }
}
