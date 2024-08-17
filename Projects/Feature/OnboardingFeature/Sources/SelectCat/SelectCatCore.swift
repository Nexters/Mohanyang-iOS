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
import Shared

import ComposableArchitecture

@Reducer
public struct SelectCatCore {
  @ObservableState
  public struct State: Equatable {
    public init() { }
    var catList: [AnyCat] = []
    var selectedCat: AnyCat? = nil
    @Presents var namingCat: NamingCatCore.State?
  }
  
  public enum Action: BindableAction {
    case onAppear
    case selectCat(AnyCat)
    case tapNextButton
    case moveToNamingCat
    case _fetchCatListRequest
    case _fetchCatListResponse(CatList)
    case _selectCatRequest
    case binding(BindingAction<State>)
    case namingCat(PresentationAction<NamingCatCore.Action>)
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
      return .run { send in await send(._fetchCatListRequest) }

    case.selectCat(let selectedCat):
      state.selectedCat = (state.selectedCat == selectedCat) ? nil : selectedCat
      return .none

    case .tapNextButton:
      return .run { send in await send(._selectCatRequest) }

    case .moveToNamingCat:
      guard let selectedCat = state.selectedCat else { return .none }
      state.namingCat = NamingCatCore.State(selectedCat: selectedCat)
      return .none

    case ._fetchCatListRequest:
      return .run { send in
        let response = try await catService.fetchCatLists(apiClient: apiClient)
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

    case ._selectCatRequest:
      guard let selectedCat = state.selectedCat else { return .none }
      return .run { send in
        _ = try await userService.selectCat(no: selectedCat.no, apiClient: apiClient)
        // user notification 요청
        _ = try await userNotificationClient.requestAuthorization([.alert, .badge, .sound])
        await send(.moveToNamingCat)
      }

    case .binding:
      return .none

    case .namingCat:
      return .none
    }
  }
}
