//
//  SelectCatCore.swift
//  OnboardingFeature
//
//  Created by 김지현 on 8/14/24.
//  Copyright © 2024 PomoNyang. All rights reserved.
//

import DatabaseClientInterface

import ComposableArchitecture

@Reducer
public struct SelectCatCore {
  @ObservableState
  public struct State: Equatable {
    var catType: CatType? = nil
  }
  
  public enum Action: BindableAction {
    case onAppear
    case selectCat(CatType)
    case tapNextButton
    case binding(BindingAction<State>)
  }
  
  public init() {}

  @Dependency(DatabaseClient.self) var databaseClient

  public var body: some ReducerOf<Self> {
    BindingReducer()
    Reduce(self.core)
  }
  
  private func core(state: inout State, action: Action) -> EffectOf<Self> {
    switch action {
    case .onAppear:
      return .none
    case.selectCat(let catType):
      state.catType = (state.catType == catType) ? nil : catType
      return .none
    case .tapNextButton:
      return .none
    case .binding:
      return .none
    }
  }
}
