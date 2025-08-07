//
//  MainTabView.swift
//  Feature
//
//  Created by devMinseok on 7/7/25.
//  Copyright © 2025 PomoNyang. All rights reserved.
//

import SwiftUI

import DesignSystem
import HomeFeature
import StatisticsFeature
import MyPageFeature

import ComposableArchitecture

public struct MainTabView: View {
  @Bindable var store: StoreOf<MainTabCore>

  public init(store: StoreOf<MainTabCore>) {
    self.store = store
  }

  public var body: some View {
    NavigationStack {
      TabView(
        selection: $store.selectedTab.sending(\.setSelectedTab)
      ) {
        HomeView(store: store.scope(state: \.home, action: \.home))
          .toolbar(.hidden, for: .tabBar)
          .tag(MainTabCore.TabType.home)

        StatisticsHomeView(store: store.scope(state: \.statisticsHome, action: \.statisticsHome))
          .toolbar(.hidden, for: .tabBar)
          .tag(MainTabCore.TabType.statistics)

        MyPageView(store: store.scope(state: \.myPage, action: \.myPage))
          .toolbar(.hidden, for: .tabBar)
          .tag(MainTabCore.TabType.myPage)
      }
      .overlay(alignment: .bottom) {
        customTabBar
      }
    }
  }

  var customTabBar: some View {
    HStack(spacing: .zero) {
      // 홈
      TabBarItemButton(
        title: MainTabCore.TabType.home.rawValue,
        isSelected: store.selectedTab == .home,
        selectedImage: DesignSystemAsset.Image.houseFill.swiftUIImage,
        unselectedImage: DesignSystemAsset.Image.house.swiftUIImage
      ) {
        store.send(.setSelectedTab(.home))
      }

      // 통계
      TabBarItemButton(
        title: MainTabCore.TabType.statistics.rawValue,
        isSelected: store.selectedTab == .statistics,
        selectedImage: DesignSystemAsset.Image.chartBarFill.swiftUIImage,
        unselectedImage: DesignSystemAsset.Image.chartBar.swiftUIImage
      ) {
        store.send(.setSelectedTab(.statistics))
      }

      // 마이페이지
      TabBarItemButton(
        title: MainTabCore.TabType.myPage.rawValue,
        isSelected: store.selectedTab == .myPage,
        selectedImage: DesignSystemAsset.Image.userFill.swiftUIImage,
        unselectedImage: DesignSystemAsset.Image.user.swiftUIImage
      ) {
        store.send(.setSelectedTab(.myPage))
      }
    }
    .padding(.horizontal, 20)
    .frame(height: 60)
    .background(Color.clear)
  }
}

struct TabBarItemButton: View {
  let title: String
  let isSelected: Bool
  let selectedImage: Image
  let unselectedImage: Image
  var tapped: () -> Void

  var body: some View {
    Button {
      tapped()
    } label: {
      VStack(spacing: 4) {
        Group {
          if isSelected {
            selectedImage
              .renderingMode(.template)
              .resizable()
          } else {
            unselectedImage
              .renderingMode(.template)
              .resizable()
          }
        }
        .frame(width: 24, height: 24)
        Text(title)
          .font(Typography.captionR)
      }
      .foregroundStyle(isSelected ? Alias.Color.Text.primary : Alias.Color.Text.tertiary)
      .frame(maxWidth: .infinity)
      .animation(nil, value: UUID())
    }
  }
}
