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
  func getToken(_ deviceID: String) async throws -> AuthDTO.Response.TokenResponseDTO {
    try await fetchData(
      target: .getToken(deviceID),
      responseData: AuthDTO.Response.TokenResponseDTO.self,
      keychainClient: self.keychainClient
    )
  }
}
