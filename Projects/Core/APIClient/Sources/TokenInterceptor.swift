//
//  TokenInterceptor.swift
//  APIClient
//
//  Created by 김지현 on 7/30/24.
//  Copyright © 2024 PomoNyang. All rights reserved.
//

import Foundation
import KeychainClientInterface
import APIClientInterface

public class TokenInterceptor: TokenInterceptorInterface {
  public var session: URLSession
  public var keychainClient: KeychainClient

  public init(session: URLSession, keychainClient: KeychainClient) {
    self.session = session
    self.keychainClient = keychainClient
  }

  public func adapt(_ request: URLRequest) async throws -> URLRequest {
    var requestWithToken = request
    if let accessToken = keychainClient.read(key: "mohanyang_keychain_access_token") {
      requestWithToken.addValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
      return requestWithToken
    } else {
      throw NetworkError.authorizationError
    }

  }

  public func retry(_ request: URLRequest, dueTo error: Error) async -> Bool {
    do {
      try await refreshAccessToken()
      return true
    } catch {
      return false
    }
  }

  private func refreshAccessToken() async throws {
// /refresh 호출하는 곳
  }
}
