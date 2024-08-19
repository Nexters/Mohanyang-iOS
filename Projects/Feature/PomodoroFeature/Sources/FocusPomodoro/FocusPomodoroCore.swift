//
//  FocusPomodoroCore.swift
//  PomodoroFeature
//
//  Created by devMinseok on 8/18/24.
//  Copyright © 2024 PomoNyang. All rights reserved.
//

import PomodoroServiceInterface
import UserDefaultsClientInterface
import DatabaseClientInterface

import ComposableArchitecture

@Reducer
public struct FocusPomodoroCore {
  @ObservableState
  public struct State: Equatable {
    var dialogueTooltip: PomodoroDialogueTooltip? {
      PomodoroDialogueTooltip(
        title: overTimeBySeconds > 0 ? "이제 나랑 놀자냥!" : "잘 집중하고 있는 거냥?"
      )
    }
    var selectedCategory: PomodoroCategory?
    
    var focusTimeBySeconds: Int = 0
    var overTimeBySeconds: Int = 0
    
    var timer: TimerCore.State = .init(interval: .seconds(1), mode: .continuous)
    
    @Presents var restWaiting: RestWaitingCore.State?
    
    public init() {}
  }
  
  public enum Action {
    case onLoad
    
    case takeRestButtonTapped
    case endFocusButtonTapped
    case setupFocusTime
    
    case goToHome
    
    case setSelectedCategory(PomodoroCategory?)
    case timer(TimerCore.Action)
    case restWaiting(PresentationAction<RestWaitingCore.Action>)
  }
  
  @Dependency(PomodoroService.self) var pomodoroService
  @Dependency(UserDefaultsClient.self) var userDefaultsClient
  @Dependency(DatabaseClient.self) var databaseClient
  @Dependency(\.dismiss) var dismiss
  
  public init() {}
  
  public var body: some ReducerOf<Self> {
    Scope(state: \.timer, action: \.timer) {
      TimerCore()
    }
    Reduce(self.core)
      .ifLet(\.$restWaiting, action: \.restWaiting) {
        RestWaitingCore()
      }
  }
  
  private func core(state: inout State, action: Action) -> EffectOf<Self> {
    switch action {
    case .onLoad:
      return .merge(
        .run { send in
          let selectedCategory = try await self.pomodoroService.getSelectedCategory(
            userDefaultsClient: self.userDefaultsClient,
            databaseClient: self.databaseClient
          )
          await send(.setSelectedCategory(selectedCategory))
          await send(.setupFocusTime)
          await send(.timer(.start))
        }
      )
      
    case .takeRestButtonTapped:
      state.restWaiting = .init()
      return .none
      
    case .endFocusButtonTapped:
      return .run { send in
        await send(.goToHome)
      }
      
    case .setupFocusTime:
      guard let selectedCategory = state.selectedCategory else { return .none }
      state.focusTimeBySeconds = selectedCategory.focusTimeMinute * 60
      return .none
      
    case .goToHome:
      return .none
      
    case let .setSelectedCategory(selectedCategory):
      state.selectedCategory = selectedCategory
      return .none
      
    case .timer(.tick):
      if state.focusTimeBySeconds <= 0 {
        if state.overTimeBySeconds >= (60 * 60) {
          // TODO: 휴식하기 이동
        } else {
          state.overTimeBySeconds += 1
        }
      } else {
        state.focusTimeBySeconds -= 1
      }
      return .none
      
    case .timer:
      return .none
      
    case .restWaiting(.presented(.restPomodoro(.presented(.goToFocus)))):
      state.restWaiting = nil
      return .none
      
    case .restWaiting:
      return .none
    }
  }
}
