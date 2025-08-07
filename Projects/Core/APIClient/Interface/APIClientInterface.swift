//
//  APIClientInterface.swift
//  APIClient
//
//  Created by 김지현 on 8/6/24.
//  Copyright © 2024 PomoNyang. All rights reserved.
//

import Foundation

import Dependencies
import DependenciesMacros

@DependencyClient
public struct APIClient {
  public var apiRequest: @Sendable (_ request: APIBaseRequest, _ isWithInterceptor: Bool) async throws -> (Data, URLResponse)

  public func apiRequest<T: Decodable>(
    request: APIBaseRequest,
    as: T.Type,
    isWithInterceptor: Bool = true
  ) async throws -> T {
    let (data, _) = try await self.apiRequest(request, isWithInterceptor)

    if T.self == EmptyResponse.self {
      return EmptyResponse() as! T
    }

    do {
      let decodedData = try customDecoder.decode(T.self, from: data)
      return decodedData
    } catch {
      print(error)
      throw NetworkError.decodingError
    }
  }

  private var customDecoder: JSONDecoder = {
    let decoder = JSONDecoder()
    decoder.dateDecodingStrategy = .custom { decoder in
      let container = try decoder.singleValueContainer()
      let dateString = try container.decode(String.self)
      let formatter = ISO8601DateFormatter()

      // 2023-07-26T00:00:00
      if let date = formatter.date(from: dateString) {
        return date
      }

      // 2023-07-26T00:00:00.000
      formatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
      if let date = formatter.date(from: dateString) {
        return date
      }

      // 2023-07-26T00:00:00
      formatter.formatOptions = [.withFullDate, .withTime, .withColonSeparatorInTime]
      if let date = formatter.date(from: dateString) {
        return date
      }

      // 2023-07-26
      formatter.formatOptions = [.withFullDate]
      if let date = formatter.date(from: dateString) {
        return date
      }

      throw DecodingError.dataCorruptedError(in: container, debugDescription: "⚠️ Date decode 실패: \(dateString)")
    }
    return decoder
  }()
}

extension APIClient: TestDependencyKey {
  public static let previewValue = Self()
  public static let testValue = Self()
}

// MARK: Empty Response 대응 논의 필요
public struct EmptyResponse: Decodable {}
