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
import DesignSystem

import RiveRuntime
import ComposableArchitecture

@Reducer
public struct SelectCatCore {
  @ObservableState
  public struct State: Equatable {
    public init(selectedCat: AnyCat? = nil, route: Route) {
      self.selectedCat = selectedCat
      self.route = route
    }
    var route: Route
    var catList: [AnyCat] = []
    var selectedCat: AnyCat?
    var catRiv: RiveViewModel = Rive.catSelectRiv()
    @Presents var namingCat: NamingCatCore.State?
  }
  
  public enum Action: BindableAction {
    case onAppear
    case selectCat(AnyCat)
    case setRivTrigger
    case selectButtonTapped
    case saveChangedCat(AnyCat)
    case _setNextAction
    case _moveToNamingCat
    case _fetchCatListRequest
    case _fetchCatListResponse(CatList)
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
        await send(.setRivTrigger)
      }

    case .selectCat(let selectedCat):
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
      return .run { send in
        _ = try await userService.selectCat(selectedCat.no, apiClient)
        await send(._setNextAction)
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
      guard let selectedCat = state.selectedCat else { return .none }
      state.namingCat = NamingCatCore.State(
        selectedCat: selectedCat,
        route: .onboarding
      )
      return .none

    case ._fetchCatListRequest:
      return .run { send in
        let response = try await catService.fetchCatLists(apiClient)
        await send(._fetchCatListResponse(response))
      }

    case ._fetchCatListResponse(let catList):
      state.catList = catList.map { cat in
        CatFactory.makeCat(
          type: CatType(rawValue: cat.type.camelCased()) ?? .cheese,
          no: cat.no,
          name: cat.name
        )
      }
      return .none

    case .binding:
      return .none

    case .namingCat:
      return .none
    }
  }
}
