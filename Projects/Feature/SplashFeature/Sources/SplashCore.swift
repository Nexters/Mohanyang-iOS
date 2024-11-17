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
import NetworkTrackingInterface
import DesignSystem

import ComposableArchitecture

@Reducer
public struct SplashCore {
  @ObservableState
  public struct State: Equatable {
    public init() { }
    var width: CGFloat = .zero
    var isLoggedIn: Bool = false

    var dialog: DefaultDialog?
  }

  public enum Action: BindableAction {
    case task
    case didFinishInitializeDatabase
    case _fetchNetworkConnection(Bool)
    case _checkDeviceIDExist
    case presentNetworkDialog
    case moveToHome
    case moveToOnboarding
    case binding(BindingAction<State>)
  }

  public init() { }

  let deviceIDKey =  "mohanyang_keychain_device_id"
  let isOnboardedKey = "mohanyang_userdefaults_isOnboarded"

  @Dependency(APIClient.self) var apiClient
  @Dependency(AuthService.self) var authService
  @Dependency(DatabaseClient.self) var databaseClient
  @Dependency(KeychainClient.self) var keychainClient
  @Dependency(UserDefaultsClient.self) var userDefaultsClient
  @Dependency(NetworkTracking.self) var networkTracking

  public var body: some ReducerOf<Self> {
    BindingReducer()
    Reduce(self.core)
  }

  private func core(_ state: inout State, _ action: Action) -> EffectOf<Self> {
    switch action {
    case .task:
      return .run { send in
        try await initilizeDatabaseSystem(databaseClient: databaseClient)
        await send(.didFinishInitializeDatabase)
      }

    case.didFinishInitializeDatabase:
      return .run { send in
        for await isConnected in networkTracking.updateNetworkConnected() {
          await send(._fetchNetworkConnection(isConnected))
        }
      }

    case ._fetchNetworkConnection(let isConnected):
      if isConnected {
        return .run { send in
          await send(._checkDeviceIDExist)
        }
      } else {
        return .run { send in
          if try await !databaseClient.checkHasTable() {
            await send(.presentNetworkDialog)
          } else {
            await send(._checkDeviceIDExist)
          }
        }
      }

    case ._checkDeviceIDExist:
      let deviceID = keychainClient.read(key: deviceIDKey) ?? getDeviceUUID()
      return login(deviceID: deviceID)

    case .presentNetworkDialog:
      state.dialog = networkErrorDialog()
      return .none

    case .moveToHome:
      return .none

    case .moveToOnboarding:
      return .none

    case .binding:
      return .none
    }
  }
}

extension SplashCore {
  private func login(deviceID: String) -> Effect<Action> {
    return .run { send in
      try await authService.login(
        deviceID: deviceID,
        apiClient: apiClient,
        keychainClient: keychainClient
      )

      try await Task.sleep(for: .seconds(1.5))
      userDefaultsClient.boolForKey(isOnboardedKey) ?
      await send(.moveToHome, animation: .easeOut(duration: 0.5)) : await send(.moveToOnboarding, animation: .easeOut(duration: 0.5))
    }
  }

  private func getDeviceUUID() -> String {
    guard let uuid = UIDevice.current.identifierForVendor?.uuidString,
          keychainClient.create(key: deviceIDKey, data: uuid) else {
      return ""
    }
    return uuid
  }
  
  private func networkErrorDialog() -> DefaultDialog {
    return DefaultDialog(
      title: "네트워크 연결을 확인해주세요",
      firstButton: DialogButtonModel(title: "확인"),
      showCloseButton: false
    )
  }
}
