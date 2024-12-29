//
//  PomodoroCore.swift
//  PomodoroFeature
//
//  Created by devMinseok on 12/30/24.
//  Copyright © 2024 PomoNyang. All rights reserved.
//

import ComposableArchitecture

@Reducer
public struct PomodoroCore {
  @ObservableState
  public struct State: Equatable {
    var focusPomodoro: FocusPomodoroCore.State = .init()
    var restWaiting: RestWaitingCore.State?
    var restPomodoro: RestPomodoroCore.State?
    
    public init() {}
  }
  
  public enum Action {
    case focusPomodoro(FocusPomodoroCore.Action)
    case restWaiting(RestWaitingCore.Action)
    case restPomodoro(RestPomodoroCore.Action)
  }
  
  public init() {}
  
  @Dependency(\.dismiss) var dismiss
  
  public var body: some ReducerOf<Self> {
    Scope(state: \.focusPomodoro, action: \.focusPomodoro) {
      FocusPomodoroCore()
    }
    Reduce(self.core)
      .ifLet(\.restWaiting, action: \.restWaiting) {
        RestWaitingCore()
      }
      .ifLet(\.restPomodoro, action: \.restPomodoro) {
        RestPomodoroCore()
      }
  }
  
  private func core(state: inout State, action: Action) -> EffectOf<Self> {
    switch action {
    case let .focusPomodoro(._moveToRestWaiting(restWaitingState)):
      state.restWaiting = restWaitingState
      return .none
      
    case .focusPomodoro(.goToHome),
        .restWaiting(.goToHome),
        .restPomodoro(.goToHome),
        .restWaiting(.goToHomeByOver60Minute):
      return .run { _ in
        await self.dismiss()
      }
      
    case .focusPomodoro:
      return .none
      
    case let .restWaiting(._moveToRestPomodoro(restPomodoroState)):
      state.restPomodoro = restPomodoroState
      return .none
      
    case .restWaiting:
      return .none
      
    case .restPomodoro(.goToFocus):
      state.restPomodoro = nil
      state.restWaiting = nil
      return .none
      
    case .restPomodoro:
      return .none
    }
  }
}
