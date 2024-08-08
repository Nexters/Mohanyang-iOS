//
//  SplashCore.swift
//  SplashFeature
//
//  Created by jihyun247 on 8/9/24.
//

import Foundation

import APIClientInterface
import AuthServiceInterface
import DatabaseClientInterface
import AppService

import ComposableArchitecture

@Reducer
public struct SplashCore {
  @ObservableState
  public struct State: Equatable {
    public init() { }
    var isLoggedIn: Bool = false
    var why: String?
  }

  public enum Action {
    case onAppear
  }

  public init() { }

  @Dependency(APIClient.self) var apiClient
  @Dependency(AuthService.self) var authService
  @Dependency(DatabaseClient.self) var databaseClient

  public var body: some ReducerOf<Self> {
    Reduce(self.core)
  }

  private func core(_ state: inout State, _ action: Action) -> EffectOf<Self> {
    switch action {
    case .onAppear:
      return .run { send in
        // TODO: - 임시로 현재 위치에 넣어논거고 Splash 개발시 SplashCore에 넣어서 작업이 완전히 끝났을때 메인화면으로 랜딩할 것.
        try await initilizeDatabaseSystem(databaseClient: databaseClient)
      }
    }
  }

}
