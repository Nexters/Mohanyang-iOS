//
//  NetworkErrorCore.swift
//  ErrorFeature
//
//  Created by 김지현 on 11/24/24.
//  Copyright © 2024 PomoNyang. All rights reserved.
//

import ComposableArchitecture

@Reducer
public struct NetworkErrorCore {
  @ObservableState
  public struct State: Equatable {
    public init() { }
  }

  public enum Action {
    case tryAgain
  }

  public init() { }

  public var body: some ReducerOf<Self> {
    Reduce(self.core)
  }

  private func core(_ state: inout State, _ action: Action) -> EffectOf<Self> {
    switch action {
    case .tryAgain:
      return .none
    }
  }

}
