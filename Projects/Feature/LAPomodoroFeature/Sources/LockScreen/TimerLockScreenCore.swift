//
//  TimerLockScreenCore.swift
//  LAPomodoroFeature
//
//  Created by devMinseok on 11/24/24.
//  Copyright © 2024 PomoNyang. All rights reserved.
//

import Foundation

import PomodoroServiceInterface

import ComposableArchitecture

@Reducer
struct TimerLockScreenCore {
  @ObservableState
  struct State: Equatable {
    var contentState: PomodoroActivityAttributes.ContentState
    
    init(contentState: PomodoroActivityAttributes.ContentState) {
      self.contentState = contentState
    }
  }
  
  enum Action {
    case stateUpdated(PomodoroActivityAttributes.ContentState)
    case updateTime
  }
  
  @Dependency(\.suspendingClock) var continuousClock
  
  init() {}
  
  var body: some ReducerOf<Self> {
    Reduce(self.core)
  }
  
  private func core(state: inout State, action: Action) -> EffectOf<Self> {
    switch action {
    case let .stateUpdated(contentState):
      state.contentState = contentState
      return .run { send in await send(.updateTime) }
      
    case .updateTime:
//      guard let contentState = state.contentState else { return .none }
//      state.timerText = timeDifferenceBetween(Date.now, contentState.goalDatetime)
      return .none
    }
  }
}
