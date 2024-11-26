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
  
  enum Action {}
  
  @Dependency(\.suspendingClock) var continuousClock
  
  init() {}
  
  var body: some ReducerOf<Self> {
    Reduce(self.core)
  }
  
  private func core(state: inout State, action: Action) -> EffectOf<Self> {
    return .none
  }
}
