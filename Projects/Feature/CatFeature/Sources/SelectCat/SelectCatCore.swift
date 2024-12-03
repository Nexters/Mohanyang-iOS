//
//  SelectCatCore.swift
//  OnboardingFeature
//
//  Created by 김지현 on 8/14/24.
//  Copyright © 2024 PomoNyang. All rights reserved.
//

import APIClientInterface
import UserServiceInterface
import CatServiceInterface
import UserNotificationClientInterface
import DatabaseClientInterface
import StreamListenerInterface
import DesignSystem

import RiveRuntime
import ComposableArchitecture

@Reducer
public struct SelectCatCore {
  @ObservableState
  public struct State: Equatable {
    var route: Route
    var catList: [SomeCat] = []
    var selectedCat: SomeCat?
    var catRiv: RiveViewModel = Rive.catSelectRiv(stateMachineName: "State Machine_selectCat")
    @Presents var namingCat: NamingCatCore.State?
    
    public init(route: Route) {
      self.route = route
    }
  }
  
  public enum Action: BindableAction {
    case onAppear
    case selectCat(SomeCat)
    case setRivTrigger
    case selectButtonTapped
    case saveChangedCat(SomeCat)
    case _setNextAction
    case _moveToNamingCat
    case _fetchCatListRequest
    case _fetchCatListResponse(Result<[Cat], Error>)
    case _postSelectedCatRequest(SelectCatRequest)
    case _postSelectedCatResponse(Result<Void, Error>)
    case binding(BindingAction<State>)
    case namingCat(PresentationAction<NamingCatCore.Action>)
  }

  public enum Route {
    case onboarding
    case myPage
  }

  public init() {}

  @Dependency(APIClient.self) var apiClient
  @Dependency(UserService.self) var userService
  @Dependency(CatService.self) var catService
  @Dependency(UserNotificationClient.self) var userNotificationClient
  @Dependency(DatabaseClient.self) var databaseClient
  @Dependency(StreamListener.self) var streamListener

  public var body: some ReducerOf<Self> {
    BindingReducer()
    Reduce(self.core)
      .ifLet(\.$namingCat, action: \.namingCat) {
        NamingCatCore()
      }
  }
  
  private func core(state: inout State, action: Action) -> EffectOf<Self> {
    switch action {
    case .onAppear:
      state.catRiv.stop()
      return .run { send in
        await send(._fetchCatListRequest)
        if let myCat = try await self.userService.getUserInfo(databaseClient: self.databaseClient)?.cat {
          await send(.set(\.selectedCat, SomeCat(baseInfo: myCat)))
        }
        await send(.setRivTrigger)
      }

    case let .selectCat(selectedCat):
      state.selectedCat = (state.selectedCat == selectedCat) ? nil : selectedCat
      state.catRiv.stop()
      return .run { send in await send(.setRivTrigger) }

    case .setRivTrigger:
      if let selectedCat = state.selectedCat {
        state.catRiv.triggerInput(selectedCat.rivTriggerName)
      } else {
        state.catRiv.play()
      }
      return .none

    case .selectButtonTapped:
      guard let selectedCat = state.selectedCat else { return .none }
      let request = SelectCatRequest(catNo: selectedCat.baseInfo.no)
      return .run { send in
        await send(._postSelectedCatRequest(request))
      }

    case .saveChangedCat:
      return .none

    case ._setNextAction:
      if state.route == .onboarding {
        return .run { send in
          // user notification 요청
          _ = try await userNotificationClient.requestAuthorization([.alert, .badge, .sound])
          await send(._moveToNamingCat)
        }
      } else {
        guard let cat = state.selectedCat else { return .none}
        return .run { send in
          await send(.saveChangedCat(cat))
        }
      }

    case ._moveToNamingCat:
      state.namingCat = NamingCatCore.State(route: .onboarding)
      return .none

    case ._fetchCatListRequest:
      return .run { send in
        await self.streamListener.protocolAdapter.send(value: ServerState.requestStarted, for: .serverState)
        await send(._fetchCatListResponse(Result {
          try await catService.getCatList(apiClient)
        }))
      }

    case let ._fetchCatListResponse(.success(response)):
      state.catList = response.map { SomeCat(baseInfo: $0) }
      return .run { send in
        await self.streamListener.protocolAdapter.send(value: ServerState.requestCompleted, for: .serverState)
      }

    case let ._fetchCatListResponse(.failure(error)):
      return handleError(error: error)

    case let ._postSelectedCatRequest(request):
      return .run { send in
        await self.streamListener.protocolAdapter.send(value: ServerState.requestStarted, for: .serverState)
        await send(._postSelectedCatResponse(Result {
          try await userService.selectCat(apiClient: self.apiClient, request: request)
        }))
      }

    case ._postSelectedCatResponse(.success(_)):
      return .run { send in
        try await userService.syncUserInfo(apiClient: self.apiClient, databaseClient: self.databaseClient)
        await self.streamListener.protocolAdapter.send(value: ServerState.requestCompleted, for: .serverState)
        await send(._setNextAction)
      }

    case let ._postSelectedCatResponse(.failure(error)):
      return handleError(error: error)

    case .binding:
      return .none

    case .namingCat:
      return .none
    }
  }
}

extension SelectCatCore {
  // TODO: 다른 곳에서도 사용될 코드인데 따로 뺄 방법 ..
  private func handleError(error: any Error) -> EffectOf<SelectCatCore> {
    if let networkError = error as? URLError,
       networkError.code == .networkConnectionLost ||
       networkError.code == .notConnectedToInternet {
      return .run { send in
        await self.streamListener.protocolAdapter.send(value: ServerState.networkDisabled, for: .serverState)
      }
    }
    guard let error = error as? NetworkError else { return .none }
    switch error {
    case .apiError(_):
      return .run { send in
        await self.streamListener.protocolAdapter.send(value: ServerState.errorOccured, for: .serverState)
      }
    default:
      return .none
    }
  }
}
