//
//  FocusPomodoroCore.swift
//  PomodoroFeature
//
//  Created by devMinseok on 8/18/24.
//  Copyright © 2024 PomoNyang. All rights reserved.
//

import CatServiceInterface
import PomodoroServiceInterface
import UserDefaultsClientInterface
import DatabaseClientInterface
import DesignSystem

import ComposableArchitecture
import RiveRuntime

@Reducer
public struct FocusPomodoroCore {
  @ObservableState
  public struct State: Equatable {
    var selectedCategory: PomodoroCategory?
    var focusTimeBySeconds: Int = 0
    var overTimeBySeconds: Int = 0
    
    var timer: TimerCore.State = .init(interval: .seconds(1), mode: .continuous)

    // 저장된 고양이 불러오고나서 이 state에 저장하면 될듯합니다
    var selectedCat: AnyCat = CatFactory.makeCat(type: .threeColor, no: 0, name: "치즈냥")

    var catRiv: RiveViewModel = Rive.catFocusRiv(stateMachineName: "State Machine_Focus")

    @Presents var restWaiting: RestWaitingCore.State?
    
    public init() {}
    
    var dialogueTooltip: PomodoroDialogueTooltip? {
      PomodoroDialogueTooltip(
        title: overTimeBySeconds > 0 ? "이제 나랑 놀자냥!" : "잘 집중하고 있는 거냥?"
      )
    }
  }
  
  public enum Action: BindableAction {
    case onAppear
    case binding(BindingAction<State>)
    case task
    
    case takeRestButtonTapped
    case endFocusButtonTapped
    case setupFocusTime
    
    case goToHome
    
    case timer(TimerCore.Action)
    case restWaiting(PresentationAction<RestWaitingCore.Action>)
  }
  
  @Dependency(PomodoroService.self) var pomodoroService
  @Dependency(UserDefaultsClient.self) var userDefaultsClient
  @Dependency(DatabaseClient.self) var databaseClient
  
  public init() {}
  
  public var body: some ReducerOf<Self> {
    BindingReducer()
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
    case .onAppear:
      state.catRiv.setInput(state.selectedCat.rivInputName, value: true)
      return .none

    case .binding:
      return .none
      
    case .task:
      return .run { send in
        let selectedCategory = try await self.pomodoroService.getSelectedCategory(
          userDefaultsClient: self.userDefaultsClient,
          databaseClient: self.databaseClient
        )
        await send(.set(\.selectedCategory, selectedCategory))
        await send(.setupFocusTime)
        await send(.timer(.start))
      }
      
    case .takeRestButtonTapped:
      state.restWaiting = RestWaitingCore.State(
        source: .focusPomodoro,
        focusedTimeBySeconds: state.focusTimeBySeconds,
        overTimeBySeconds: state.overTimeBySeconds
      )
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
      
    case .timer(.tick):
      if state.focusTimeBySeconds == 0 {
        if state.overTimeBySeconds == 3600 { // 60분 초과시 휴식 대기화면으로 이동
          return .run { [state] send in
            await send(.timer(.stop)) // task가 cancel을 해주지만 일단 action 중복을 방지하기 위해 명시적으로 stop
            await send(
              .set(
                \.restWaiting,
                 RestWaitingCore.State(
                  source: .overtimeFromFocusPomodoro,
                  focusedTimeBySeconds: state.focusTimeBySeconds,
                  overTimeBySeconds: state.overTimeBySeconds
                 )
              )
            )
          }
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
