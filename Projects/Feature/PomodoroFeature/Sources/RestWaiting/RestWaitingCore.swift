//
//  RestWaitingCore.swift
//  PomodoroFeature
//
//  Created by devMinseok on 8/20/24.
//  Copyright © 2024 PomoNyang. All rights reserved.
//

import Foundation

import PomodoroServiceInterface
import UserDefaultsClientInterface
import DatabaseClientInterface
import APIClientInterface
import DesignSystem

import ComposableArchitecture

@Reducer
public struct RestWaitingCore {
  @ObservableState
  public struct State: Equatable {
    let source: Source
    var selectedCategory: PomodoroCategory?
    var restWaitingTimeBySeconds: Int = 60 * 30 // 휴식 대기는 30분 고정
    var overTimeBySeconds: Int = 0
    var changeFocusTimeByMinute: Int = 0
    
    var timer: TimerCore.State = .init(interval: .seconds(1), mode: .continuous)
    var toast: DefaultToast?
    
    @Presents var restPomodoro: RestPomodoroCore.State?
    
    public init(source: Source) {
      self.source = source
    }
    
    var minus5MinuteButtonDisabled: Bool {
      guard let focusTimeMinute = selectedCategory?.focusTimeMinute else { return false }
      return focusTimeMinute <= 10
    }
    var plus5MinuteButtonDisabled: Bool {
      guard let focusTimeMinute = selectedCategory?.focusTimeMinute else { return false }
      return focusTimeMinute >= 60
    }
  }
  
  public enum Action: BindableAction {
    case binding(BindingAction<State>)
    case task
    case minus5MinuteButtonTapped
    case plus5MinuteButtonTapped
    case takeRestButtonTapped
    case endFocusButtonTapped
    
    case goToHome
    case goToHomeByOver60Minute
    
    case timer(TimerCore.Action)
    case restPomodoro(PresentationAction<RestPomodoroCore.Action>)
  }
  
  public enum Source {
    case focusPomodoro
    case overtimeFromFocusPomodoro
  }
  
  @Dependency(PomodoroService.self) var pomodoroService
  @Dependency(UserDefaultsClient.self) var userDefaultsClient
  @Dependency(DatabaseClient.self) var databaseClient
  @Dependency(APIClient.self) var apiClient
  
  public init() {}
  
  public var body: some ReducerOf<Self> {
    BindingReducer()
    Scope(state: \.timer, action: \.timer) {
      TimerCore()
    }
    Reduce(self.core)
      .ifLet(\.$restPomodoro, action: \.restPomodoro) {
        RestPomodoroCore()
      }
  }
  
  private func core(state: inout State, action: Action) -> EffectOf<Self> {
    switch action {
    case .binding:
      return .none
      
    case .task:
      return .run { send in
        let selectedCategory = try await self.pomodoroService.getSelectedCategory(
          userDefaultsClient: self.userDefaultsClient,
          databaseClient: self.databaseClient
        )
        await send(.set(\.selectedCategory, selectedCategory))
        await send(.timer(.start))
      }
      
    case .minus5MinuteButtonTapped:
      guard !state.minus5MinuteButtonDisabled else {
        state.toast = .init(message: "10분은 집중해야 해요", image: DesignSystemAsset.Image._24Clock.swiftUIImage)
        return .none
      }
      if state.changeFocusTimeByMinute == -5 {
        state.changeFocusTimeByMinute = 0
      } else {
        state.changeFocusTimeByMinute = -5
      }
      return .none
      
    case .plus5MinuteButtonTapped:
      guard !state.plus5MinuteButtonDisabled else {
        state.toast = .init(message: "최대 60분까지만 집중할 수 있어요", image: DesignSystemAsset.Image._24Clock.swiftUIImage)
        return .none
      }
      if state.changeFocusTimeByMinute == 5 {
        state.changeFocusTimeByMinute = 0
      } else {
        state.changeFocusTimeByMinute = 5
      }
      return .none
      
    case .takeRestButtonTapped:
      return .run { [state] send in
        try await applyChangeFocusTime(state: state)
        await send(.set(\.restPomodoro, RestPomodoroCore.State()))
      }
      
    case .endFocusButtonTapped:
      return .run { [state] send in
        try await applyChangeFocusTime(state: state)
        await send(.goToHome)
      }
      
    case .goToHome:
      return .none
      
    case .goToHomeByOver60Minute:
      return .none
      
    case .timer(.tick):
      if state.restWaitingTimeBySeconds == 0 {
        if state.overTimeBySeconds == 1800 { // 30분 초과시 홈화면으로 나가기
          return .run { send in
            await send(.timer(.stop)) // task가 cancel을 해주지만 일단 action 중복을 방지하기 위해 명시적으로 stop
            await send(.goToHomeByOver60Minute)
          }
        } else {
          state.overTimeBySeconds += 1
        }
      } else {
        state.restWaitingTimeBySeconds -= 1
      }
      return .none
      
    case .timer:
      return .none
      
    case .restPomodoro:
      return .none
    }
  }
  
  func applyChangeFocusTime(state: State) async throws -> Void {
    guard let selectedCategory = state.selectedCategory,
          state.changeFocusTimeByMinute != 0
    else { return }
    
    let changedTimeMinute = selectedCategory.focusTimeMinute + state.changeFocusTimeByMinute
    let iso8601Duration = DateComponents(minute: changedTimeMinute).to8601DurationString()
    let request = EditCategoryRequest(focusTime: iso8601Duration, restTime: nil)
    
    try await self.pomodoroService.changeCategoryTime(
      apiClient: self.apiClient,
      categoryID: selectedCategory.id,
      request: request
    )
    try await self.pomodoroService.syncCategoryList(
      apiClient: self.apiClient,
      databaseClient: self.databaseClient
    )
  }
}
