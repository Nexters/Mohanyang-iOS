//
//  AccessTokenInterceptor.swift
//  APIClient
//
//  Created by 김지현 on 7/29/24.
//  Copyright © 2024 PomoNyang. All rights reserved.
//

import Foundation
import KeychainClientInterface
import APIClientInterface

class AccessTokenInterceptor: AccessTokenInterceptorInterface {
  var keychainClient: KeychainClient
  init(keychainClient: KeychainClient) {
    self.keychainClient = keychainClient
  }


  func adapt(_ request: URLRequest) async throws -> URLRequest {
    var requestWithToken = request
    if let accessToken = keychainClient.read(key: "mohanyang_keychain_access_token") {
      requestWithToken.addValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
      return requestWithToken
    } else {
      throw NetworkError.authorizationError
    }

  }

  func retry(_ request: URLRequest, dueTo error: Error) async -> Bool {
    do {
      try await refreshAccessToken()
      return true
    } catch {
      return false
    }
  }

  private func refreshAccessToken() async throws {

  }
}
