//
//  HomeCore.swift
//  HomeFeature
//
//  Created by devMinseok on 7/22/24.
//  Copyright © 2024 PomoNyang. All rights reserved.
//

import UserNotifications

import PushService
import UserDefaultsClientInterface

import ComposableArchitecture

@Reducer
public struct HomeCore {
  @ObservableState
  public struct State: Equatable {
    
    var homeCatTooltip: HomeCatDialogueTooltip?
    var homeCategoryGuideTooltip: HomeCategoryGuideTooltip?
    var homeTimeGuideTooltip: HomeTimeGuideTooltip?
    @Presents var categorySelect: CategorySelectCore.State?
    @Presents var timeSelect: TimeSelectCore.State?
    
    public init() {}
  }
  
  public enum Action {
    case onLoad
    case setHomeCatTooltip(HomeCatDialogueTooltip?)
    case setHomeCategoryGuideTooltip(HomeCategoryGuideTooltip?)
    case setHomeTimeGuideTooltip(HomeTimeGuideTooltip?)
    case categoryButtonTapped
    case focusTimeButtonTapped
    case relaxTimeButtonTapped
    case mypageButtonTappd
    case playButtonTapped
    
    case categorySelect(PresentationAction<CategorySelectCore.Action>)
    case timeSelect(PresentationAction<TimeSelectCore.Action>)
  }
  
  @Dependency(UserDefaultsClient.self) var userDefaultsClient
  let isHomeGuideCompletedKey = "mohanyang_userdefaults_isHomeGuideCompleted"
  
  public init() {}
  
  public var body: some ReducerOf<Self> {
    Reduce(self.core)
      .ifLet(\.$categorySelect, action: \.categorySelect) {
        CategorySelectCore()
      }
      .ifLet(\.$timeSelect, action: \.timeSelect) {
        TimeSelectCore()
      }
  }
  
  private func core(_ state: inout State, _ action: Action) -> EffectOf<Self> {
    switch action {
    case .onLoad:
      return .run { send in
        await send(.setHomeCatTooltip(nil))
        if self.userDefaultsClient.boolForKey(isHomeGuideCompletedKey) == false {
          await self.userDefaultsClient.setBool(true, key: isHomeGuideCompletedKey)
          await send(.setHomeCategoryGuideTooltip(HomeCategoryGuideTooltip()))
        }
      }
      
    case .setHomeCatTooltip:
      state.homeCatTooltip = .init(title: "오랜만이다냥") // TODO: - 문구 랜덤변경하기
      return .none
      
    case let .setHomeCategoryGuideTooltip(tooltip):
      state.homeCategoryGuideTooltip = tooltip
      if tooltip == nil {
        state.homeTimeGuideTooltip = .init()
      }
      return .none
      
    case let .setHomeTimeGuideTooltip(tooltip):
      state.homeTimeGuideTooltip = tooltip
      return .none
      
    case .categoryButtonTapped:
      state.categorySelect = CategorySelectCore.State()
      return .none
      
    case .focusTimeButtonTapped:
      state.timeSelect = TimeSelectCore.State()
      return .none
      
    case .relaxTimeButtonTapped:
      state.timeSelect = TimeSelectCore.State()
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
      
    case .timeSelect:
      return .none
    }
  }
}
