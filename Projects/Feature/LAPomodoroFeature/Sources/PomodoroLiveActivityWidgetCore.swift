//
//  PomodoroLiveActivityWidgetCore.swift
//  LAPomodoroFeature
//
//  Created by devMinseok on 11/24/24.
//  Copyright © 2024 PomoNyang. All rights reserved.
//

import ComposableArchitecture

@Reducer
struct PomodoroLiveActivityWidgetCore {
  @ObservableState
  struct State: Equatable {
//    var timerLockScreen: TimerLockScreenCore.State = .init()
    
    init() {}
  }
  
  enum Action {
    case timerLockScreen(TimerLockScreenCore.Action)
  }
  
//  <#@Dependency() var#>
  
  init() {}
  
  var body: some ReducerOf<Self> {
//    Scope(state: \.timerLockScreen, action: \.timerLockScreen) {
//      TimerLockScreenCore()
//    }
    Reduce(self.core)
  }
  
  private func core(state: inout State, action: Action) -> EffectOf<Self> {
    switch action {
    case .timerLockScreen:
      return .none
    }
  }
}
