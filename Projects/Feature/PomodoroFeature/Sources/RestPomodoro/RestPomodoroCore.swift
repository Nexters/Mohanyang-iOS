//
//  RestPomodoroCore.swift
//  PomodoroFeature
//
//  Created by devMinseok on 8/19/24.
//  Copyright © 2024 PomoNyang. All rights reserved.
//

import PomodoroServiceInterface

import ComposableArchitecture

@Reducer
public struct RestPomodoroCore {
  @ObservableState
  public struct State: Equatable {
    var dialogueTooltip: PomodoroDialogueTooltip? {
      PomodoroDialogueTooltip(
        title: overTimeBySeconds > 0 ? "쉬는 게 제일 좋다냥" : "이제 다시 사냥놀이 하자냥!"
      )
    }
    
    var selectedCategory: PomodoroCategory?
    var restTimeBySeconds: Int = 60 * 30
    var overTimeBySeconds: Int = 0
    
    public init() {}
  }
  
  public enum Action {
    case onLoad
    
    case focusAgainButtonTapped
    case endFocusButtonTapped
    case minus5MinuteButtonTapped
    case plus5MinuteButtonTapped
    
    case goToHome
    case goToFocus
  }
  
  //  <#@Dependency() var#>
  
  public init() {}
  
  public var body: some ReducerOf<Self> {
    Reduce(self.core)
  }
  
  private func core(state: inout State, action: Action) -> EffectOf<Self> {
    switch action {
    case .onLoad:
      return .none
      
    case .focusAgainButtonTapped:
      return .run { send in
        await send(.goToFocus)
      }
      
    case .endFocusButtonTapped:
      return .run { send in
        await send(.goToHome)
      }
      
    case .minus5MinuteButtonTapped:
      return .none
      
    case .plus5MinuteButtonTapped:
      return .none
      
    case .goToHome:
      return .none
      
    case .goToFocus:
      return .none
    }
  }
}
