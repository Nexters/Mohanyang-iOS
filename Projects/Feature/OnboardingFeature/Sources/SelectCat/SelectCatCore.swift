//
//  SelectCatCore.swift
//  OnboardingFeature
//
//  Created by 김지현 on 8/14/24.
//  Copyright © 2024 PomoNyang. All rights reserved.
//

import ComposableArchitecture

@Reducer
public struct SelectCatCore {
  @ObservableState
  public struct State: Equatable {
    var catType: CatType?
    var cat: (any CatFactoryProtocol)? {
      if let catType = catType {
        return CatFactory.makeCat(type: catType)
      } else {
        return nil
      }
    }
  }
  
  public enum Action {
    case onAppear
  }
  
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
