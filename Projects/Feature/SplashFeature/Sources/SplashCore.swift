//
//  SplashCore.swift
//  SplashFeature
//
//  Created by jihyun247 on 8/9/24.
//

import UIKit

import APIClientInterface
import AuthServiceInterface
import DatabaseClientInterface
import KeychainClientInterface
import UserDefaultsClientInterface
import AppService

import ComposableArchitecture

@Reducer
public struct SplashCore {
  @ObservableState
  public struct State: Equatable {
    public init() { }
    var isLoggedIn: Bool = false
  }

  public enum Action {
    case onAppear
    case didFinishInitializeDatabase
    case moveToHome
    case moveToOnboarding
  }

  public init() { }

  @Dependency(APIClient.self) var apiClient
  @Dependency(AuthService.self) var authService
  @Dependency(DatabaseClient.self) var databaseClient
  @Dependency(KeychainClient.self) var keychainClient
  @Dependency(UserDefaultsClient.self) var userDefaultsClient

  public var body: some ReducerOf<Self> {
    Reduce(self.core)
  }

  private func core(_ state: inout State, _ action: Action) -> EffectOf<Self> {
    switch action {
    case .onAppear:
      return .run { send in
        try await initilizeDatabaseSystem(databaseClient: databaseClient)
        await send(.didFinishInitializeDatabase)
      }
    case.didFinishInitializeDatabase:
      return checkDeviceIDExist()
    default:
      return .none
    }
  }
}

extension SplashCore {
  private func checkDeviceIDExist() -> Effect<Action> {
    if keychainClient.read(key: KeychainKeys.deviceID.rawValue) != nil {
      return checkAccessTokenExist()
    } else {
      let deviceID = getDeviceUUID()
      return login(deviceID: deviceID)
    }
  }

  private func checkAccessTokenExist() -> Effect<Action> {
    if keychainClient.read(key: KeychainKeys.accessToken.rawValue) != nil {
      return checkOnboardingDone()
    } else {
      let deviceID = keychainClient.read(key: KeychainKeys.deviceID.rawValue)!
      return login(deviceID: deviceID)
    }
  }

  private func checkOnboardingDone() -> Effect<Action> {
    return .run { send in
      try await Task.sleep(for: .seconds(1.5))
      userDefaultsClient.boolForKey(UserDefaultsKeys.isOnboarded.rawValue) ?
      await send(.moveToHome) : await send(.moveToOnboarding)
    }
  }

  private func login(deviceID: String) -> Effect<Action> {
    return .run { send in
      _ = try await authService.login(
        deviceID: deviceID,
        apiClient: apiClient,
        keychainCleint: keychainClient
      )

      try await Task.sleep(for: .seconds(1.5))
      await send(.moveToOnboarding)
    }
  }

  private func getDeviceUUID() -> String {
    guard let uuid = UIDevice.current.identifierForVendor?.uuidString,
          keychainClient.create(key: KeychainKeys.deviceID.rawValue, data: uuid) else {
      return ""
    }
    return uuid
  }
}
