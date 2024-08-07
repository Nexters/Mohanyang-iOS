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
  public var apiRequest: @Sendable (
    _ request: APIBaseRequest,
    _ isWithInterceptor: Bool
  ) async throws -> (Data, URLResponse)

  public func apiRequest<T: Decodable>(
    request: APIBaseRequest,
    as: T.Type,
    isWithInterceptor: Bool = true
  ) async throws -> T {
    let (data, _) = try await self.apiRequest(request, isWithInterceptor)

    do {
      let decodedData = try JSONDecoder().decode(T.self, from: data)
      return decodedData
    } catch {
      throw NetworkError.decodingError
    }
  }
}

extension APIClient: TestDependencyKey {
  public static let previewValue = Self()
  public static let testValue = Self()
}
