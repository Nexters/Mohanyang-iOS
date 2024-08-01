//
//  AccessTokenInterceptorInterface.swift
//  APIClient
//
//  Created by 김지현 on 7/29/24.
//  Copyright © 2024 PomoNyang. All rights reserved.
//

import Foundation
import KeychainClientInterface

protocol TokenInterceptorInterface {
  // adapt, retry 각각 매개변수로 받을지, 프로토콜 변수로 놓을지 고민
  var keychainClient: KeychainClient { get set }
  func adapt(_ request: URLRequest) async throws -> URLRequest
  func retry(_ request: URLRequest, dueTo error: Error) async -> Bool
}

public class TokenInterceptor: TokenInterceptorInterface {
  var keychainClient: KeychainClient

  public init(keychainClient: KeychainClient) {
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

  }
}
