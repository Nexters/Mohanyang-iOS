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
import DesignSystem

import ComposableArchitecture
import RiveRuntime

@Reducer
public struct NamingCatCore {
  @ObservableState
  public struct State: Equatable {
    public init(selectedCat: AnyCat, route: Route) {
      self.selectedCat = selectedCat
      self.route = route
    }

    var route: Route
    var selectedCat: AnyCat
    var text: String = ""
    var isButtonDisabled: Bool = false
    var inputFieldError: NamingCatError?
    var tooltip: DownDirectionTooltip? = .init()
    var catRiv: RiveViewModel = Rive.catSelectRiv(stateMachineName: "State Machine_selectCat")
  }
  
  public enum Action: BindableAction {
    case onAppear
    case namedButtonTapped
    case moveToHome
    case setTooltip(DownDirectionTooltip?)
    case saveChangedCatName(String)
    case _setNextAction
    case binding(BindingAction<State>)
  }

  public enum Route {
    case onboarding
    case myPage
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
      if state.route == .myPage {
        state.isButtonDisabled = true
      }
      state.catRiv.stop()
      state.catRiv.triggerInput(state.selectedCat.rivTriggerName)
      return .none

    case .namedButtonTapped:
      let catName = state.text == "" ? state.selectedCat.name : state.text
      return .run { send in
        _ = try await catService.changeCatName(
          apiClient: apiClient,
          name: catName
        )
        await send(._setNextAction)
      }

    case .moveToHome:
      return .none
      
    case .setTooltip:
      return .none

    case .saveChangedCatName:
      return .none

    case ._setNextAction:
      if state.route == .onboarding {
        return .run { send in
          await userDefaultsClient.setBool(true, key: isOnboardedKey)
          await send(.moveToHome)
        }
      } else {
        return .run { [name = state.text] send in
          await send(.saveChangedCatName(name))
        }
      }

    case .binding(\.text):
      state.inputFieldError = setError(state.text)
      if state.text == "" && state.route == .myPage {
        state.isButtonDisabled = true
      } else if state.inputFieldError != nil {
        state.isButtonDisabled = true
      } else if state.inputFieldError == nil {
        state.isButtonDisabled = false
      }
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
