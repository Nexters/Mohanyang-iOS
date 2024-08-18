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
import DatabaseClientInterface
import PomodoroServiceInterface
import APIClientInterface

import ComposableArchitecture

@Reducer
public struct HomeCore {
  @ObservableState
  public struct State: Equatable {
    
    var homeCatTooltip: HomeCatDialogueTooltip?
    var homeCategoryGuideTooltip: HomeCategoryGuideTooltip?
    var homeTimeGuideTooltip: HomeTimeGuideTooltip?
    
    var selectedCategory: PomodoroCategory?
    
    @Presents var categorySelect: CategorySelectCore.State?
    @Presents var timeSelect: TimeSelectCore.State?
    
    public init() {}
  }
  
  public enum Action: BindableAction {
    case binding(BindingAction<State>)
    case onLoad
    case onAppear
    case setHomeCatTooltip(HomeCatDialogueTooltip?)
    case setHomeCategoryGuideTooltip(HomeCategoryGuideTooltip?)
    case setHomeTimeGuideTooltip(HomeTimeGuideTooltip?)
    case categoryButtonTapped
    case focusTimeButtonTapped
    case restTimeButtonTapped
    case mypageButtonTappd
    case playButtonTapped
    
    case syncCategory
    
    case categorySelect(PresentationAction<CategorySelectCore.Action>)
    case timeSelect(PresentationAction<TimeSelectCore.Action>)
  }
  
  @Dependency(UserDefaultsClient.self) var userDefaultsClient
  @Dependency(DatabaseClient.self) var databaseClient
  @Dependency(APIClient.self) var apiClient
  @Dependency(PomodoroService.self) var pomodoroService
  let isHomeGuideCompletedKey = "mohanyang_userdefaults_isHomeGuideCompleted"
  
  public init() {}
  
  public var body: some ReducerOf<Self> {
    BindingReducer()
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
    case .binding:
      return .none
      
    case .onLoad:
      return .run { send in
        await send(.setHomeCatTooltip(nil))
        if self.userDefaultsClient.boolForKey(isHomeGuideCompletedKey) == false {
          await self.userDefaultsClient.setBool(true, key: isHomeGuideCompletedKey)
          await send(.setHomeCategoryGuideTooltip(HomeCategoryGuideTooltip()))
        }
      }
      
    case .onAppear:
      return .run { send in
        await send(.syncCategory)
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
      state.timeSelect = TimeSelectCore.State(mode: .focus)
      return .none
      
    case .restTimeButtonTapped:
      state.timeSelect = TimeSelectCore.State(mode: .rest)
      return .none
      
    case .mypageButtonTappd:
      return .none
      
    case .playButtonTapped:
      return .none
      
    case .syncCategory:
      return .run { send in
        try await self.pomodoroService.syncCategoryList(
          apiClient: self.apiClient,
          databaseClient: self.databaseClient
        )
        if let selectedCategory = try await self.pomodoroService.getSelectedCategory(
          userDefaultsClient: self.userDefaultsClient,
          databaseClient: self.databaseClient
        ) {
          await send(.set(\.selectedCategory, selectedCategory))
        } else {
          let categoryList = try await self.pomodoroService.getCategoryList(databaseClient: self.databaseClient)
          if let basicCategory = categoryList.first(where: { $0.baseCategoryCode == .basic }) {
            await self.pomodoroService.changeSelectedCategory(
              userDefaultsClient: self.userDefaultsClient,
              categoryID: basicCategory.id
            )
            await send(.set(\.selectedCategory, basicCategory))
          }
        }
      }
      
    case .categorySelect(.dismiss):
      return .run { send in
        await send(.syncCategory)
      }
      
    case .categorySelect:
      return .none
      
    case .timeSelect(.dismiss):
      return .run { send in
        await send(.syncCategory)
      }
      
    case .timeSelect:
      return .none
    }
  }
}
