//
//  CategoryIconSelectCore.swift
//  HomeFeature
//
//  Created by 김지현 on 3/4/25.
//  Copyright © 2025 PomoNyang. All rights reserved.
//
import PomodoroServiceInterface
import ComposableArchitecture

@Reducer
public struct CategoryIconSelectCore {
  @ObservableState
  public struct State: Equatable {
    var selectedIcon: PomodoroIconType

    public init(selectedIcon: PomodoroIconType) {
      self.selectedIcon = selectedIcon
    }
  }

  public enum Action {
    case selectIcon(PomodoroIconType)
  }

  public var body: some ReducerOf<Self> {
    Reduce(self.core)
  }

  private func core(state: inout State, action: Action) -> EffectOf<Self> {
    switch action {
    case .selectIcon(let icon):
      state.selectedIcon = icon
      return .none
    }
  }
}
