//
//  HomeCore.swift
//  HomeFeature
//
//  Created by devMinseok on 7/22/24.
//  Copyright © 2024 PomoNyang. All rights reserved.
//

import UserNotifications

import PushService
import UserNotificationClientInterface

import ComposableArchitecture

@Reducer
public struct HomeCore {
  @ObservableState
  public struct State: Equatable {
    
    var homeCatTooltip: HomeCatDialogueTooltip?
    var homeCategoryGuideTooltip: HomeCategoryGuideTooltip?
    var homeTimeGuideTooltip: HomeTimeGuideTooltip?
    @Presents var categorySelect: CategorySelectCore.State?
    
    public init() {}
  }
  
  public enum Action {
    case onAppear
    case setHomeCatTooltip(HomeCatDialogueTooltip?)
    case setHomeCategoryGuideTooltip(HomeCategoryGuideTooltip?)
    case setHomeTimeGuideTooltip(HomeTimeGuideTooltip?)
    case categoryButtonTapped
    case mypageButtonTappd
    case playButtonTapped
    
    case categorySelect(PresentationAction<CategorySelectCore.Action>)
  }
  
  public enum Mode {
    case normal
    /// 가이드모드
    case guide
  }
  
  @Dependency(UserNotificationClient.self) var userNotificationClient
  
  public init() {}
  
  public var body: some ReducerOf<Self> {
    Reduce(self.core)
      .ifLet(\.$categorySelect, action: \.categorySelect) {
        CategorySelectCore()
      }
  }
  
  private func core(_ state: inout State, _ action: Action) -> EffectOf<Self> {
    switch action {
    case .onAppear:
      state.homeCatTooltip = .init(title: "오랜만이다냥")
      state.homeCategoryGuideTooltip = .init()
      return .none
      
    case let .setHomeCatTooltip(tooltip):
      return .none
      
    case let .setHomeCategoryGuideTooltip(tooltip):
      state.homeCategoryGuideTooltip = tooltip
      state.homeTimeGuideTooltip = .init()
      return .none
      
    case let .setHomeTimeGuideTooltip(tooltip):
      state.homeTimeGuideTooltip = tooltip
      return .none
      
    case .categoryButtonTapped:
      state.categorySelect = CategorySelectCore.State()
      return .none
      
    case .mypageButtonTappd:
      return .none
      
    case .playButtonTapped:
      return .none
      
    case .categorySelect(.presented(.dismissButtonTapped)):
      state.categorySelect = nil
      return .none
      
    case .categorySelect:
      return .none
    }
  }
}
