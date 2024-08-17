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
public struct NamingCatCore {
  @ObservableState
  public struct State: Equatable {
    public init(selectedCat: AnyCat) {
      self.selectedCat = selectedCat
    }

    var selectedCat: AnyCat
    var text: String = ""
    var inputFieldError: NamingCatError?
    var tooltip: DownDirectionTooltip? = .init()
  }
  
  public enum Action: BindableAction {
    case onAppear
    case tapStartButton
    case binding(BindingAction<State>)
  }
  
  @Dependency(APIClient.self) var apiClient
  @Dependency(CatService.self) var catService

  public init() {}

  public var body: some ReducerOf<Self> {
    BindingReducer()
    Reduce(self.core)
  }
  
  private func core(state: inout State, action: Action) -> EffectOf<Self> {
    switch action {
    case .onAppear:
      return .none

    case .tapStartButton:
      return .none

    case .binding:
      return .none
    }
  }
}
