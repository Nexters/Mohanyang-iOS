//
//  APIClientInterface.swift
//  APIClient
//
//  Created by 김지현 on 8/6/24.
//  Copyright © 2024 PomoNyang. All rights reserved.
//

import Foundation

import Logger

import Dependencies
import DependenciesMacros

@DependencyClient
public struct APIClient {
  public var apiRequest: @Sendable (_ request: APIBaseRequest, _ token: String?) async throws -> (Data, URLResponse)

  public func apiRequest<T: Decodable>(
    request: APIBaseRequest,
    as: T.Type,
    token: String?
  ) async throws -> T {
    let (data, response) = try await self.apiRequest(request, token)

    guard let httpResponse = response as? HTTPURLResponse else {
      throw NetworkError.noResponseError
    }

    switch httpResponse.statusCode {
    case 200..<300:
      do {
        let decodedData = try JSONDecoder().decode(T.self, from: data)
        return decodedData
      } catch {
        throw NetworkError.decodingError
      }
    case 401:
      throw NetworkError.authorizationError
    case 400..<500:
      throw NetworkError.requestError("bad request")
    case 500..<600:
      throw NetworkError.serverError
    default:
      throw NetworkError.unknownError
    }
  }
}

extension APIClient: TestDependencyKey {
  public static let previewValue = Self()
  public static let testValue = Self()
}
