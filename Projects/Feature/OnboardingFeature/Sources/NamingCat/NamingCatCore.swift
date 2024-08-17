//
//  NamingCatCore.swift
//  OnboardingFeature
//
//  Created by 김지현 on 8/17/24.
//  Copyright © 2024 PomoNyang. All rights reserved.
//

import UserDefaultsClientInterface
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
    case moveToHome
    case setTooltip(DownDirectionTooltip?)
    case binding(BindingAction<State>)
  }
  
  @Dependency(UserDefaultsClient.self) var userDefaultsClient
  @Dependency(APIClient.self) var apiClient
  @Dependency(CatService.self) var catService

  public init() {}

  public var body: some ReducerOf<Self> {
    BindingReducer()
    Reduce(self.core)
  }

  private func core(state: inout State, action: Action) -> EffectOf<Self> {
    let isOnboardedKey = "mohanyang_userdefaults_isOnboarded"

    switch action {
    case .onAppear:
      return .none

    case .tapStartButton:
      return .run { [text = state.text] send in
        _ = try await catService.changeCatName(
          apiClient: apiClient,
          name: text
        )
        await userDefaultsClient.setBool(true, key: isOnboardedKey)
        await send(.moveToHome)
      }

    case .moveToHome:
      return .none
      
    case .setTooltip:
      return .none

    case .binding(\.text):
      state.inputFieldError = setError(state.text)
      return .none

    case .binding:
      return .none
    }
  }

  private func setError(_ text: String) -> NamingCatError? {
    var error: NamingCatError? = nil

    if text == " " {
      error = .startsWithWhiteSpace
    } else if text.count > 10 {
      error = .exceedsMaxLength
    } else if text.containsWhitespaceOrSpecialCharacters() {
      error = .hasSpecialCharacter
    } else {
      error = nil
    }

    return error
  }
}
