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

        _ = keychainClient.create(key: "mohanyang_keychain_access_token", data: response.accessToken)
        _ = keychainClient.create(key: "mohanyang_keychain_refresh_token", data: response.refreshToken)
        return
      }
    )
  }

  private static func isTokenValid(_ keychainClient: KeychainClient) -> Bool {
    let isTokenExist = keychainClient.read(key: "mohanyang_keychain_access_token")
    return isTokenExist != nil
  }
}
