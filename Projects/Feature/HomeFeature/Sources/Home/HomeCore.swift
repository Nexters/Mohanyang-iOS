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
import UserServiceInterface
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
    var selectedCat: SomeCat?
    
    var isNetworkConnected: Bool = true
    
    var toast: DefaultToast?
    var dialog: DefaultDialog?
    
    var catRiv: RiveViewModel = Rive.catHomeRiv(stateMachineName: "State Machine_Home")
    
    @Presents var categorySelect: CategorySelectCore.State?
    @Presents var timeSelect: TimeSelectCore.State?
    @Presents var myPage: MyPageCore.State?
    @Presents var pomodoro: PomodoroCore.State?
    
    public init() {}
  }
  
  public enum Action: BindableAction {
    case binding(BindingAction<State>)
    case task
    case onLoad
    case onAppear
    case changeHomeCatTooltipMessage
    case setHomeCategoryGuideTooltip(HomeCategoryGuideTooltip?)
    case setHomeTimeGuideTooltip(HomeTimeGuideTooltip?)
    case categoryButtonTapped
    case focusTimeButtonTapped
    case restTimeButtonTapped
    case mypageButtonTappd
    case playButtonTapped
    case catTapped
    case catSetInput
    case _fetchNetworkConnection(Bool)
    case syncCategory
    case categorySelect(PresentationAction<CategorySelectCore.Action>)
    case timeSelect(PresentationAction<TimeSelectCore.Action>)
    case myPage(PresentationAction<MyPageCore.Action>)
    case pomodoro(PresentationAction<PomodoroCore.Action>)
  }
  
  @Dependency(UserDefaultsClient.self) var userDefaultsClient
  @Dependency(DatabaseClient.self) var databaseClient
  @Dependency(APIClient.self) var apiClient
  @Dependency(PomodoroService.self) var pomodoroService
  @Dependency(NetworkTracking.self) var networkTracking
  @Dependency(UserService.self) var userService
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
      .ifLet(\.$myPage, action: \.myPage) {
        MyPageCore()
      }
      .ifLet(\.$pomodoro, action: \.pomodoro) {
        PomodoroCore()
      }
  }
  
  private func core(_ state: inout State, _ action: Action) -> EffectOf<Self> {
    switch action {
    case .binding:
      return .none
      
    case .task:
      return .run { send in
        for await isConnected in networkTracking.updateNetworkConnected() {
          await send(._fetchNetworkConnection(isConnected))
        }
      }
      
    case .onLoad:
      return .run { send in
        if self.userDefaultsClient.boolForKey(isHomeGuideCompletedKey) == false {
          await self.userDefaultsClient.setBool(true, key: isHomeGuideCompletedKey)
          await send(.setHomeCategoryGuideTooltip(HomeCategoryGuideTooltip()))
        }
      }
      
    case .onAppear:
      return .run { send in
        await send(.syncCategory)
        if let myCat = try await self.userService.getUserInfo(databaseClient: self.databaseClient)?.cat {
          await send(.set(\.selectedCat, SomeCat(baseInfo: myCat)))
        }
        await send(.catSetInput)
        await send(.changeHomeCatTooltipMessage)
      }
      
    case .changeHomeCatTooltipMessage:
      let title = state.selectedCat?.generateTooltipMessage() ?? ""
      state.homeCatTooltip = .init(title: title)
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
      state.pomodoro = .init()
      return .none
      
    case .catTapped:
      guard let selectedCat = state.selectedCat else { return .none }
      state.catRiv.triggerInput(selectedCat.rivTriggerName)
      return .run { send in
        await send(.changeHomeCatTooltipMessage)
      }
      
    case .catSetInput:
      guard let selectedCat = state.selectedCat else { return .none }
      state.catRiv.reset()
      state.catRiv.setInput(selectedCat.rivInputName, value: true)
      return .none
      
    case let ._fetchNetworkConnection(isConnected):
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
      guard let mode = state.timeSelect?.mode,
            state.timeSelect?.isTimeChanged == true
      else { return .none }
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
      
    case let .pomodoro(.presented(.focusPomodoro(.saveHistory(focusTimeBySeconds, restTimeBySeconds)))), // FocusPomodoro
      let .pomodoro(.presented(.restWaiting(.saveHistory(focusTimeBySeconds, restTimeBySeconds)))), // RestWaiting
      let .pomodoro(.presented(.restPomodoro(.saveHistory(focusTimeBySeconds, restTimeBySeconds)))): // RestPomodoro
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
      
    case .pomodoro(.presented(.restWaiting(.goToHomeByOver60Minute))):
      state.dialog = focusEndDialog()
      return .none
      
    case .pomodoro:
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
      focusedTime: focusedTime ?? "PT0M",
      restedTime: restedTime ?? "PT0M",
      doneAt: Date()
    )
    try await self.pomodoroService.saveFocusTimeHistory(
      apiClient: self.apiClient,
      databaseClient: self.databaseClient,
      request: [request]
    )
  }
}

extension HomeCore {
  private func focusEndDialog() -> DefaultDialog {
    return DefaultDialog(
      title: "집중을 끝내고 돌아왔어요",
      subTitle: "너무 오랜 시간동안 대기화면에 머물러서 홈화면으로 이동되었어요.",
      firstButton: DialogButtonModel(title: "확인"),
      showCloseButton: false
    )
  }
}
