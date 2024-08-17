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

  let deviceIDKey =  "mohanyang_keychain_device_id"
  let isOnboardedKey = "mohanyang_userdefaults_isOnboarded"

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
    let deviceID = keychainClient.read(key: deviceIDKey) ?? getDeviceUUID()
    return login(deviceID: deviceID)
  }

  private func login(deviceID: String) -> Effect<Action> {
    return .run { send in
      try await authService.login(
        deviceID: deviceID,
        apiClient: apiClient,
        keychainClient: keychainClient
      )

      try await Task.sleep(for: .seconds(1.5))
      userDefaultsClient.boolForKey(isOnboardedKey) ?
      await send(.moveToHome) : await send(.moveToOnboarding)
    }
  }

  private func getDeviceUUID() -> String {
    guard let uuid = UIDevice.current.identifierForVendor?.uuidString,
          keychainClient.create(key: deviceIDKey, data: uuid) else {
      return ""
    }
    return uuid
  }
}
