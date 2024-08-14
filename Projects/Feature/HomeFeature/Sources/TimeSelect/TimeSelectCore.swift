//
//  TimeSelectCore.swift
//  HomeFeature
//
//  Created by devMinseok on 8/13/24.
//  Copyright © 2024 PomoNyang. All rights reserved.
//

import ComposableArchitecture

@Reducer
public struct TimeSelectCore {
  @ObservableState
  public struct State: Equatable {
    
  }
  
  public enum Action {
    case onAppear
  }
  
//  <#@Dependency() var#>
  
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
