//
//  MainTabCore.swift
//  Feature
//
//  Created by devMinseok on 7/7/25.
//  Copyright © 2025 PomoNyang. All rights reserved.
//

import HomeFeature
import StatisticsFeature
import MyPageFeature

import ComposableArchitecture

@Reducer
public struct MainTabCore {
  @ObservableState
  public struct State: Equatable {
    var selectedTab: TabType = .statistics
    var home: HomeCore.State = .init()
    var statisticsHome: StatisticsHomeCore.State = .init()
    var myPage: MyPageCore.State = .init()
  }

  public enum Action {
    case onAppear
    case home(HomeCore.Action)
    case statisticsHome(StatisticsHomeCore.Action)
    case myPage(MyPageCore.Action)
    case setSelectedTab(TabType)
  }

  public enum TabType: String {
    case home = "홈"
    case statistics = "통계"
    case myPage = "마이페이지"
  }

  public init() {}

  public var body: some ReducerOf<Self> {
    Scope(state: \.home, action: \.home) {
      HomeCore()
    }
    Scope(state: \.statisticsHome, action: \.statisticsHome) {
      StatisticsHomeCore()
    }
    Scope(state: \.myPage, action: \.myPage) {
      MyPageCore()
    }
    Reduce(self.core)
  }

  private func core(state: inout State, action: Action) -> EffectOf<Self> {
    switch action {
    case .onAppear:
      return .none

    case .home:
      return .none

    case .statisticsHome:
      return .none

    case .myPage:
      return .none

    case let .setSelectedTab(selectedTab):
      state.selectedTab = selectedTab
      return .none
    }
  }
}
