//
//  SelectCatCore.swift
//  OnboardingFeature
//
//  Created by 김지현 on 8/14/24.
//  Copyright © 2024 PomoNyang. All rights reserved.
//

import APIClientInterface
import UserServiceInterface

import ComposableArchitecture

@Reducer
public struct SelectCatCore {
  @ObservableState
  public struct State: Equatable {
    var catList: CatList = []
    var catType: CatType? = nil
  }
  
  public enum Action: BindableAction {
    case onAppear
    case selectCat(CatType)
    case tapNextButton
    case _fetchCatListRequest
    case _fetchCatListResponse(CatList)
    case binding(BindingAction<State>)
  }
  
  public init() {}

  @Dependency(APIClient.self) var apiClient
  @Dependency(UserService.self) var userService

  public var body: some ReducerOf<Self> {
    BindingReducer()
    Reduce(self.core)
  }
  
  private func core(state: inout State, action: Action) -> EffectOf<Self> {
    switch action {
    case .onAppear:
      return .run { send in await send(._fetchCatListRequest) }
    case.selectCat(let catType):
      state.catType = (state.catType == catType) ? nil : catType
      return .none
    case .tapNextButton:
      return .none
    case ._fetchCatListRequest:
      return .run { send in
        let response = try await userService.getCatLists(apiClient: apiClient)
        await send(._fetchCatListResponse(response))
      }
    case ._fetchCatListResponse(let catList):
      state.catList = catList
      return .none
    case .binding:
      return .none
    }
  }
}
