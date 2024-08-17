//
//  NamingCatCore.swift
//  OnboardingFeature
//
//  Created by 김지현 on 8/17/24.
//  Copyright © 2024 PomoNyang. All rights reserved.
//

import APIClientInterface
import CatServiceInterface

import ComposableArchitecture

@Reducer
struct NamingCatCore {
  @ObservableState
  struct State: Equatable {
    var text: String = ""
  }
  
  enum Action {
    case onAppear
  }
  
  @Dependency(APIClient.self) var apiClient
  //@Dependency(CatService.self) var catService

  init() {}
  
  var body: some ReducerOf<Self> {
    Reduce(self.core)
  }
  
  private func core(state: inout State, action: Action) -> EffectOf<Self> {
    switch action {
    case .onAppear:
      return .none
    }
  }
}
