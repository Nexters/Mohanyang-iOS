//
//  AuthAPIClient.swift
//  AuthService
//
//  Created by 김지현 on 8/3/24.
//  Copyright © 2024 PomoNyang. All rights reserved.
//

import Foundation
import KeychainClientInterface
import AuthServiceInterface
import Dependencies

extension AuthAPIClient: DependencyKey {
  public static let liveValue: AuthAPIClient = .live()
  private static func live() -> AuthAPIClient {
    // MARK: CAT-98: keychain을 feature에서부터 가지고 오는 방법 ..
    @Dependency(\.keychainClient) var keychainClient
    return AuthAPIClient(
      getToken: { deviceID in
        var response = try await LocalAuthAPI(keychainClient: keychainClient).getToken(deviceID)
        return response
      }
    )
  }
}
