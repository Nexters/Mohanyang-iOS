//
//  AuthAPIClient.swift
//  AuthService
//
//  Created by 김지현 on 8/3/24.
//  Copyright © 2024 PomoNyang. All rights reserved.
//

import Foundation
import KeychainClientInterface
import UserDefaultsClientInterface
import AuthServiceInterface
import Dependencies

enum KeychainClientKeys: String {
  case accessToken = "mohanyang_keychain_access_token"
  case refreshToken = "mohanyang_keychain_refresh_token"
}

extension AuthService: DependencyKey {
  public static let liveValue: AuthService = .live()
  private static func live() -> Self {
    return AuthService(
      login: { deviceID, apiClient, keychainClient in
        guard !isTokenValid(keychainClient) else { return }

        let service = AuthAPIRequest.login(deviceID)
        let response = try await apiClient.apiRequest(
          request: service,
          as: AuthDTO.Response.TokenResponseDTO.self,
          isWithInterceptor: false
        )

        _ = keychainClient.create(key: KeychainClientKeys.accessToken.rawValue, data: response.accessToken)
        _ = keychainClient.create(key: KeychainClientKeys.refreshToken.rawValue, data: response.refreshToken)
        return
      }
    )
  }

  private static func isTokenValid(_ keychainClient: KeychainClient) -> Bool {
    let isTokenExist = keychainClient.read(key: KeychainClientKeys.accessToken.rawValue)
    return isTokenExist != nil
  }
}
