//
//  HomeView.swift
//  HomeFeatureInterface
//
//  Created by devMinseok on 7/22/24.
//  Copyright © 2024 PomoNyang. All rights reserved.
//

import SwiftUI

import MyPageFeature
import PomodoroFeature
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
      leading: { Spacer() },
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
          store.catRiv.view()
            .setTooltipTarget(tooltip: HomeCatDialogueTooltip.self)
            .onTapGesture {
              store.send(.catTapped)
            }
            .frame(width: 240, height: 240)
          
          Text(store.selectedCat?.baseInfo.name ?? "")
            .font(Typography.header4)
            .foregroundStyle(Alias.Color.Text.secondary)
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
              Text("\(store.selectedCategory?.focusTimeMinutes ?? 0)분")
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
              Text("\(store.selectedCategory?.restTimeMinutes ?? 0)분")
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
    .overlay {
      if !store.isNetworkConnected {
        VStack {
          HStack(spacing: Alias.Spacing.small) {
            DesignSystemAsset.Image._16NullPrimary.swiftUIImage
            Text("오프라인 모드")
              .font(Typography.bodySB)
              .foregroundStyle(Alias.Color.Text.secondary)
          }
          .padding(.horizontal, Alias.Spacing.large)
          .padding(.vertical, Alias.Spacing.small)
          .background {
            RoundedRectangle(cornerRadius: Alias.BorderRadius.max)
              .foregroundStyle(Global.Color.white)
              .shadow(radius: Alias.BorderRadius.max, y: 4)
          }
          .padding(.top, Alias.Spacing.large)
          Spacer()
        }
      }
    }
    .tooltipDestination(tooltip: $store.homeCatTooltip.sending(\.setHomeCatTooltip))
    .tooltipDestination(tooltip: $store.homeCategoryGuideTooltip.sending(\.setHomeCategoryGuideTooltip))
    .tooltipDestination(tooltip: $store.homeTimeGuideTooltip.sending(\.setHomeTimeGuideTooltip))
    .toastDestination(toast: $store.toast)
    .dialog(dialog: $store.dialog)
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
        state: \.focusPomodoro,
        action: \.focusPomodoro
      )
    ) { store in
      FocusPomodoroView(store: store)
    }
    .navigationDestination(
      item: $store.scope(
        state: \.myPage,
        action: \.myPage
      )
    ) { store in
      MyPageView(store: store)
    }
    .task {
      await store.send(.task).finish()
    }
    .onLoad {
      store.send(.onLoad)
    }
    .onAppear {
      store.send(.onAppear)
    }
  }
}
