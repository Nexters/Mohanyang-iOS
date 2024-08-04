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
    return AuthAPIClient(
      getToken: { deviceID, keychainClient in
        var response = try await LocalAuthAPI().getToken(deviceID, keychainClient)
        return response
      }
    )
  }
}
