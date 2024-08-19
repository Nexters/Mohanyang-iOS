//
//  MyPageCore.swift
//  MyPageFeature
//
//  Created by 김지현 on 8/19/24.
//  Copyright © 2024 PomoNyang. All rights reserved.
//

import CatFeature
import APIClientInterface
import UserServiceInterface

import ComposableArchitecture

@Reducer
public struct MyPageCore {
  @ObservableState
  public struct State: Equatable {
    public init() { }
    var cat: AnyCat? = nil
    var isFocusTimeAlarmOn: Bool = false
    var isDisturbAlarmOn: Bool = false
    var isInternetConnected: Bool = false
  }
  
  public enum Action: BindableAction {
    case onAppear
    case _responseUserInfo(UserDTO.Response.GetUserInfoResponseDTO)
    case binding(BindingAction<State>)
  }

  @Dependency(APIClient.self) var apiClient
  @Dependency(UserService.self) var userService

  public init() {}
  
  public var body: some ReducerOf<Self> {
    BindingReducer()
    Reduce(self.core)
  }
  
  private func core(state: inout State, action: Action) -> EffectOf<Self> {
    switch action {
    case .onAppear:
      return .run { send in
        let data = try await userService.getUserInfo(apiClient: apiClient)
        await send(._responseUserInfo(data))
      }
    case ._responseUserInfo(let data):
      state.cat = CatFactory.makeCat(
        type: CatType(rawValue: data.cat.type.camelCased()) ?? .cheese,
        no: data.cat.no,
        name: data.cat.name
      )
      return .none
    case .binding:
      return .none
    }
  }
}
