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
import Logger
import Dependencies

enum KeychainClientKeys: String {
  case accessToken = "mohanyang_keychain_access_token"
  case refreshToken = "mohanyang_keychain_refresh_token"
}

struct TokenInterceptor {
  @Dependency(KeychainClient.self) var keychainClient

  /// add accessToken to url request's header
  func adapt(
    _ request: URLRequest
  ) async throws -> URLRequest {
    var requestWithToken = request
    if let accessToken = keychainClient.read(key: KeychainClientKeys.accessToken.rawValue) {
      requestWithToken.addValue(
        "Bearer \(accessToken)",
        forHTTPHeaderField: HTTPHeaderField.authentication.rawValue
      )
      return requestWithToken
    } else {
      throw NetworkError.authorizationError
    }
  }

  /// refresh access token
  func retry(
    for session: URLSession
  ) async throws {

    guard let refreshToken = keychainClient.read(key: KeychainClientKeys.refreshToken.rawValue) else {
      throw NetworkError.authorizationError
    }

    var urlRequest = URLRequest(url: URL(string: "https://" + API.apiBaseURL)!)
    urlRequest.httpMethod = HTTPMethod.post.rawValue
    urlRequest.setValue(
      ContentType.json.rawValue,
      forHTTPHeaderField: HTTPHeaderField.contentType.rawValue
    )

    let requestBody = ["refreshToken": refreshToken]
    urlRequest.httpBody = try? JSONSerialization.data(withJSONObject: requestBody, options: [])

    let (data, response) = try await session.data(for: urlRequest)

    guard let httpResponse = response as? HTTPURLResponse else {
      let error = NetworkError.noResponseError
      Logger.shared.log(level: .error, category: .network, "API Error:\n\(dump(error))")
      throw error
    }

    guard (200...299).contains(httpResponse.statusCode) else {
      let error = NetworkError.authorizationError
      Logger.shared.log(level: .error, category: .network, "API Error:\n\(dump(error))")
      keychainClient.deleteAll() // MARK: - 인증오류시 키체인 리셋 해야함 (이게 없으면 공장초기화 아니면 앱 못 쓰게됨)
      throw error
    }

    let decodedData = try JSONDecoder().decode(TokenResponseDTO.self, from: data)
    _ = keychainClient.update(key: KeychainClientKeys.accessToken.rawValue, data: decodedData.accessToken)
  }
}
