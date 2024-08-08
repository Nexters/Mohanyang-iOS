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

extension AuthService: DependencyKey {
  public static let liveValue: AuthService = .live()
  private static func live() -> Self {
    return AuthService(
      login: { deviceID, apiClient in
        let service = AuthAPIRequest.login(deviceID)
        let response = try await apiClient.apiRequest(
          request: service,
          as: AuthDTO.Response.TokenResponseDTO.self,
          isWithInterceptor: false
        )
        return response
      }
    )
  }
}
