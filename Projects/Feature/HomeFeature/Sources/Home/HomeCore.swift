//
//  HomeCore.swift
//  HomeFeature
//
//  Created by devMinseok on 7/22/24.
//  Copyright © 2024 PomoNyang. All rights reserved.
//

import UserNotifications

import PomodoroFeature
import NetworkTrackingInterface
import PushService
import CatServiceInterface
import PomodoroServiceInterface
import UserDefaultsClientInterface
import DatabaseClientInterface
import APIClientInterface
import MyPageFeature
import DesignSystem

import ComposableArchitecture
import RiveRuntime

@Reducer
public struct HomeCore {
  @ObservableState
  public struct State: Equatable {
    var homeCatTooltip: HomeCatDialogueTooltip?
    var homeCategoryGuideTooltip: HomeCategoryGuideTooltip?
    var homeTimeGuideTooltip: HomeTimeGuideTooltip?
    
    var selectedCategory: PomodoroCategory?
    // 저장된 고양이 불러오고나서 이 state에 저장하면 될듯합니다
    var selectedCat: AnyCat = CatFactory.makeCat(type: .threeColor, no: 0, name: "치즈냥")

    var isNetworkConnected: Bool = false

    var toast: DefaultToast?
    var dialog: DefaultDialog?

    var catRiv: RiveViewModel = Rive.catHomeRiv(stateMachineName: "State Machine_Home")

    @Presents var categorySelect: CategorySelectCore.State?
    @Presents var timeSelect: TimeSelectCore.State?
    @Presents var focusPomodoro: FocusPomodoroCore.State?
    @Presents var myPage: MyPageCore.State?

    public init() {}
  }
  
  public enum Action: BindableAction {
    case binding(BindingAction<State>)
    case task
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
    case _fetchNetworkConntection(Bool)

    case syncCategory
    
    case categorySelect(PresentationAction<CategorySelectCore.Action>)
    case timeSelect(PresentationAction<TimeSelectCore.Action>)
    case focusPomodoro(PresentationAction<FocusPomodoroCore.Action>)
    case myPage(PresentationAction<MyPageCore.Action>)
  }
  
  @Dependency(UserDefaultsClient.self) var userDefaultsClient
  @Dependency(DatabaseClient.self) var databaseClient
  @Dependency(APIClient.self) var apiClient
  @Dependency(PomodoroService.self) var pomodoroService
  @Dependency(NetworkTracking.self) var networkTracking
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
      .ifLet(\.$focusPomodoro, action: \.focusPomodoro) {
        FocusPomodoroCore()
      }
      .ifLet(\.$myPage, action: \.myPage) {
        MyPageCore()
      }
  }
  
  private func core(_ state: inout State, _ action: Action) -> EffectOf<Self> {
    switch action {
    case .binding:
      return .none

    case .task:
      return .run { send in
        for await isConnected in networkTracking.updateNetworkConnected() {
          await send(._fetchNetworkConntection(isConnected))
        }
      }

    case .onLoad:
      return .run { send in
        await send(.setHomeCatTooltip(nil))
        if self.userDefaultsClient.boolForKey(isHomeGuideCompletedKey) == false {
          await self.userDefaultsClient.setBool(true, key: isHomeGuideCompletedKey)
          await send(.setHomeCategoryGuideTooltip(HomeCategoryGuideTooltip()))
        }
      }
      
    case .onAppear:
      state.catRiv.setInput(state.selectedCat.rivInputName, value: true)
      return .run { send in
        await send(.syncCategory)
      }
      
    case .setHomeCatTooltip:
      state.homeCatTooltip = .init(title: state.selectedCat.tooltipMessage)
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
      state.myPage = MyPageCore.State()
      return .none
      
    case .playButtonTapped:
      state.focusPomodoro = .init()
      return .none

    case let ._fetchNetworkConntection(isConnected):
      state.isNetworkConnected = isConnected
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
      
    case .categorySelect(.presented(.bottomCheckButtonTapped)):
      state.toast = DefaultToast(
        message: "카테고리를 변경했어요",
        image: DesignSystemAsset.Image._24CheckSecondary.swiftUIImage
      )
      return .none
      
    case .categorySelect(.dismiss):
      return .run { send in
        await send(.syncCategory)
      }
      
    case .categorySelect:
      return .none
      
    case .timeSelect(.presented(.bottomCheckButtonTapped)):
      guard let mode = state.timeSelect?.mode else { return .none }
      var message: String
      switch mode {
      case .focus:
        message = "집중시간을 변경했어요"
      case .rest:
        message = "휴식시간을 변경했어요"
      }
      state.toast = DefaultToast(
        message: message,
        image: DesignSystemAsset.Image._24CheckSecondary.swiftUIImage
      )
      return .none
      
    case .timeSelect(.dismiss):
      return .run { send in
        await send(.syncCategory)
      }
      
    case .timeSelect:
      return .none
      
    case .myPage:
      return .none
      
    case let .focusPomodoro(.presented(.saveHistory(focusTimeBySeconds, restTimeBySeconds))), // FocusPomodoro
      let .focusPomodoro(.presented(.restWaiting(.presented(.saveHistory(focusTimeBySeconds, restTimeBySeconds))))), // RestWaiting
      let .focusPomodoro(.presented(.restWaiting(.presented(.restPomodoro(.presented(.saveHistory(focusTimeBySeconds, restTimeBySeconds))))))): // RestPomodoro
      guard let selectedCategoryID = state.selectedCategory?.id else { return .none }
      if focusTimeBySeconds >= 60 {
        return .run { _ in
          try await self.saveFocusTime(
            selectedCategoryID: selectedCategoryID,
            focusTimeBySeconds: focusTimeBySeconds,
            restTimeBySeconds: restTimeBySeconds
          )
        }
      } else {
        state.toast = DefaultToast(
          message: "최소 1분 이상은 집중해야 기록돼요",
          image: DesignSystemAsset.Image._24Clock.swiftUIImage
        )
        return .none
      }
      
    case .focusPomodoro(.presented(.restWaiting(.presented(.goToHomeByOver60Minute)))):
      state.focusPomodoro = nil
      state.dialog = DefaultDialog(
        title: "집중을 끝내고 돌아왔어요",
        subTitle: "너무 오랜 시간동안 대기화면에 머물러서 홈화면으로 이동되었어요.",
        firstButton: DialogButtonModel(title: "확인")
      )
      return .none
      
    case .focusPomodoro(.presented(.goToHome)),
        .focusPomodoro(.presented(.restWaiting(.presented(.goToHome)))),
        .focusPomodoro(.presented(.restWaiting(.presented(.restPomodoro(.presented(.goToHome)))))):
      state.focusPomodoro = nil
      return .none
      
    case .focusPomodoro:
      return .none
    }
  }
  
  func saveFocusTime(
    selectedCategoryID: Int,
    focusTimeBySeconds: Int,
    restTimeBySeconds: Int
  ) async throws -> Void {
    let focusedTime = DateComponents(minute: focusTimeBySeconds / 60, second: focusTimeBySeconds % 60).to8601DurationString()
    let restedTime = DateComponents(minute: restTimeBySeconds / 60, second: restTimeBySeconds % 60).to8601DurationString()
    let request = FocusTimeHistory(
      categoryNo: selectedCategoryID,
      focusedTime: focusedTime,
      restedTime: restedTime,
      doneAt: Date()
    )
    try await self.pomodoroService.saveFocusTimeHistory(
      apiClient: self.apiClient,
      databaseClient: self.databaseClient,
      request: [request]
    )
  }
}
