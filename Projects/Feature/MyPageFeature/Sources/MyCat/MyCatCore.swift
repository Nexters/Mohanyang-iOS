//
//  MyCatCore.swift
//  MyPageFeature
//
//  Created by 김지현 on 8/19/24.
//  Copyright © 2024 PomoNyang. All rights reserved.
//

import CatFeature

import ComposableArchitecture

@Reducer
public struct MyCatCore {
  @ObservableState
  public struct State: Equatable {
    var cat: AnyCat?
  }
  
  public enum Action {
    case onAppear
  }
  
  // @Dependency

  public init() {}
  
  public var body: some ReducerOf<Self> {
    Reduce(self.core)
  }
  
  private func core(state: inout State, action: Action) -> EffectOf<Self> {
    switch action {
    case .onAppear:
      return .none
    }
  }
}
