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
import UserServiceInterface
import DatabaseClientInterface
import StreamListenerInterface

import ComposableArchitecture
import RiveRuntime

@Reducer
public struct NamingCatCore {
  @ObservableState
  public struct State: Equatable {
    var route: Route
    var selectedCat: SomeCat?
    var text: String = ""
    var isButtonDisabled: Bool = false
    var inputFieldError: NamingCatError?
    var tooltip: DownDirectionTooltip? = .init()
    var catRiv: RiveViewModel = Rive.catRenameRiv(stateMachineName: "State Machine_Rename")

    var height: CGFloat = .zero

    public init(route: Route) {
      self.route = route
    }
  }
  
  public enum Action: BindableAction {
    case onAppear
    case namedButtonTapped
    case catSetInput
    case moveToHome
    case setTooltip(DownDirectionTooltip?)
    case saveChangedCat(SomeCat)
    case _setNextAction
    case _postNamedCatRequest(ChangeCatNameRequest)
    case _postNamedCatResponse(Result<Void, Error>)
    case binding(BindingAction<State>)
  }

  public enum Route {
    case onboarding
    case myPage
  }

  @Dependency(UserDefaultsClient.self) var userDefaultsClient
  @Dependency(APIClient.self) var apiClient
  @Dependency(CatService.self) var catService
  @Dependency(UserService.self) var userService
  @Dependency(DatabaseClient.self) var databaseClient
  @Dependency(StreamListener.self) var streamListener
  let isOnboardedKey = "mohanyang_userdefaults_isOnboarded"

  public init() {}

  public var body: some ReducerOf<Self> {
    BindingReducer()
    Reduce(self.core)
  }

  private func core(state: inout State, action: Action) -> EffectOf<Self> {
    switch action {
    case .onAppear:
      if state.route == .myPage {
        state.isButtonDisabled = true
      }
      return .run { send in
        if let myCat = try await self.userService.getUserInfo(databaseClient: self.databaseClient)?.cat {
          await send(.set(\.selectedCat, SomeCat(baseInfo: myCat)))
        }
        await send(.catSetInput)
      }

    case .namedButtonTapped:
      guard let selectedCat = state.selectedCat else { return .none }
      let catName = state.text == "" ? selectedCat.baseInfo.name : state.text
      let request = ChangeCatNameRequest(name: catName)
      return .run { send in
        await send(._postNamedCatRequest(request))
      }
      
    case .catSetInput:
      guard let selectedCat = state.selectedCat else { return .none }
      state.catRiv.reset()
      state.catRiv.setInput(selectedCat.rivInputName, value: true)
      return .none

    case .moveToHome:
      return .none
      
    case .setTooltip:
      return .none

    case .saveChangedCat:
      return .none
      
    case ._setNextAction:
      return .run { [state] send in
        if state.route == .onboarding {
          await self.userDefaultsClient.setBool(true, key: isOnboardedKey)
          await send(.moveToHome)
        } else {
          if let selectedCat = state.selectedCat {
            await send(.saveChangedCat(selectedCat))
          }
        }
      }

    case let ._postNamedCatRequest(request):
      return .run { send in
        await self.streamListener.protocolAdapter.send(ServerState.requestStarted)
        await send(._postNamedCatResponse(Result {
          try await self.catService.changeCatName(apiClient: apiClient, request: request)
        }))
      }

    case ._postNamedCatResponse(.success(_)):
      return .run { send in
        try await self.userService.syncUserInfo(apiClient: self.apiClient, databaseClient: self.databaseClient)
        await self.streamListener.protocolAdapter.send(ServerState.requestCompleted)
        await send(._setNextAction)
      }

    case let ._postNamedCatResponse(.failure(error)):
      return self.handleError(error: error)

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

extension NamingCatCore {
  private func handleError(error: any Error) -> EffectOf<NamingCatCore> {
    if let networkError = error as? URLError,
       networkError.code == .networkConnectionLost ||
       networkError.code == .notConnectedToInternet {
      return .run { send in
        await self.streamListener.protocolAdapter.send(ServerState.networkDisabled)
      }
    }
    guard let error = error as? NetworkError else { return .none }
    switch error {
    case .apiError(_):
      return .run { send in
        await self.streamListener.protocolAdapter.send(ServerState.errorOccured)
      }
    default:
      return .none
    }
  }
}
