//
//  OnboardingCore.swift
//  OnboardingFeature
//
//  Created by devMinseok on 7/22/24.
//  Copyright © 2024 PomoNyang. All rights reserved.
//

import OnboardingFeatureInterface

import ComposableArchitecture

@Reducer
public struct OnboardingCore {
  @ObservableState
  public struct State: Equatable {
    public init() { }
    var data: [OnboardingItem] = OnboardingItemsData
  }

  public enum Action {
    case onApear
  }

  public init() { }

  public var body: some ReducerOf<Self> {
    Reduce(self.core)
  }

  private func core(_ state: inout State, _ action: Action) -> EffectOf<Self> {
    switch action {
    case .onApear:
      return .none
    }
  }
}
