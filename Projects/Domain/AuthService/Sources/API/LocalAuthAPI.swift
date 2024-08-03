//
//  AuthAPI.swift
//  AuthService
//
//  Created by 김지현 on 8/3/24.
//  Copyright © 2024 PomoNyang. All rights reserved.
//

import Foundation
import APIClient
import AuthServiceInterface
import KeychainClientInterface

class LocalAuthAPI: APIRequestLoader<AuthAPIService> {
  func getToken(_ deviceId: String) async throws -> AuthDTO.Response.TokenResponseDTO {
    return try await fetchData(
      target: .getToken(deviceId),
      responseData: AuthDTO.Response.TokenResponseDTO.self,
      keychainClient: self.keychainClient
    )
  }
}
