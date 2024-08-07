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

actor Session {
  nonisolated let tokenInterceptor: TokenInterceptor

  let session: URLSession = {
    let config = URLSessionConfiguration.default
    return URLSession(configuration: config)
  }()

  let decoder: JSONDecoder = JSONDecoder()

  init(tokenInterceptor: TokenInterceptor) {
    self.tokenInterceptor = tokenInterceptor
  }

  func sendRequest(request: APIBaseRequest) async throws -> (Data, URLResponse) {

    let urlRequest = try await request.asURLRequest()
    Logger.shared.log(category: .network, "API Request:\n\(dump(urlRequest))")

    let (data, response) = try await session.data(for: urlRequest)

    guard let httpResponse = response as? HTTPURLResponse else {
      let error = NetworkError.noResponseError
      Logger.shared.log(level: .error, category: .network, "API Error:\n\(dump(error))")
      throw error
    }

    func throwNetworkErr(_ error: NetworkError) -> NetworkError {
      Logger.shared.log(level: .error, category: .network, "\(error.localizedDescription):\n\(dump(error))")
      return error
    }
    switch httpResponse.statusCode {
    case 200..<300:
      return (data, response)
    case 401:
      if await tokenInterceptor.retry(urlRequest, for: self.session) {
        return try await sendRequest(request: request)
      } else {
        throw throwNetworkErr(.unknownError)
      }
    case 400..<500:
      throw throwNetworkErr(.requestError("bad request"))
    case 500..<600:
      throw throwNetworkErr(.serverError)
    default:
      throw throwNetworkErr(.unknownError)
    }
  }
}

struct TokenInterceptor {
  @Dependency(KeychainClient.self) var keychainClient

  func adapt(
    _ request: URLRequest,
    for session: Session
  ) async throws -> URLRequest {
    var requestWithToken = request
    if let accessToken = keychainClient.read(key: "mohanyang_keychain_access_token") {
      requestWithToken.addValue(
        "Bearer \(accessToken)",
        forHTTPHeaderField: HTTPHeaderField.authentication.rawValue
      )
      return requestWithToken
    } else {
      throw NetworkError.authorizationError
    }

  }

  func retry(
    _ request: URLRequest,
    for session: URLSession
  ) async -> Bool {
    return true
  }
}
