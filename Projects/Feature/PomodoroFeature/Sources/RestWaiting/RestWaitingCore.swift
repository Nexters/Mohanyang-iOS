//
//  RestWaitingCore.swift
//  PomodoroFeature
//
//  Created by devMinseok on 8/20/24.
//  Copyright © 2024 PomoNyang. All rights reserved.
//

import PomodoroServiceInterface

import ComposableArchitecture

@Reducer
public struct RestWaitingCore {
  @ObservableState
  public struct State: Equatable {
    var selectedCategory: PomodoroCategory?
    var restWaitingTimeBySeconds: Int = 60 * 30
    var overTimeBySeconds: Int = 0
    
    @Presents var restPomodoro: RestPomodoroCore.State?
    
    public init() {}
  }
  
  public enum Action {
    case onLoad
    case minus5MinuteButtonTapped
    case plus5MinuteButtonTapped
    case takeRestButtonTapped
    case endFocusButtonTapped
    case goToHome
    case restPomodoro(PresentationAction<RestPomodoroCore.Action>)
  }
  
//  <#@Dependency() var#>
  
  public init() {}
  
  public var body: some ReducerOf<Self> {
    Reduce(self.core)
      .ifLet(\.$restPomodoro, action: \.restPomodoro) {
        RestPomodoroCore()
      }
  }
  
  private func core(state: inout State, action: Action) -> EffectOf<Self> {
    switch action {
    case .onLoad:
      return .none
      
    case .minus5MinuteButtonTapped:
      return .none
      
    case .plus5MinuteButtonTapped:
      return .none
      
    case .takeRestButtonTapped:
      state.restPomodoro = .init()
      return .none
      
    case .endFocusButtonTapped:
      return .run { send in
        await send(.goToHome)
      }
      
    case .goToHome:
      return .none
      
    case .restPomodoro:
      return .none
    }
  }
}
