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
      login: { deviceID, apiClient in
        let service = AuthAPIService.login(deviceID)
        var response = try await apiClient.apiRequest(
          request: service,
          as: AuthDTO.Response.TokenResponseDTO.self
        ) 
        return response
      }
    )
  }
}
