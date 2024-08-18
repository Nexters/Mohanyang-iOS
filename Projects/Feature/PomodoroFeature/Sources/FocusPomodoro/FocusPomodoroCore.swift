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
    var dialogueTooltip: PomodoroDialogueTooltip?
    var selectedCategory: PomodoroCategory?
    
    
    public init() {}
  }
  
  public enum Action: BindableAction {
    case binding(BindingAction<State>)
    case onLoad
    case setDialogueTooltip(PomodoroDialogueTooltip?)
  }
  
  @Dependency(PomodoroService.self) var pomodoroService
  @Dependency(UserDefaultsClient.self) var userDefaultsClient
  @Dependency(DatabaseClient.self) var databaseClient
  
  public init() {}
  
  public var body: some ReducerOf<Self> {
    BindingReducer()
    Reduce(self.core)
  }
  
  private func core(state: inout State, action: Action) -> EffectOf<Self> {
    switch action {
    case .binding:
      return .none
      
    case .onLoad:
      state.dialogueTooltip = PomodoroDialogueTooltip(title: "잘 집중하고 있는 거냥?")
      return .run { send in
        let selectedCategory = try await self.pomodoroService.getSelectedCategory(
          userDefaultsClient: self.userDefaultsClient,
          databaseClient: self.databaseClient
        )
        await send(.set(\.selectedCategory, selectedCategory))
      }
      
    case .setDialogueTooltip:
      return .none
    }
  }
}
