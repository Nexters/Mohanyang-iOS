//
//  APIClient.swift
//  APIClient
//
//  Created by 김지현 on 8/6/24.
//  Copyright © 2024 PomoNyang. All rights reserved.
//

import Foundation

import Logger
import APIClientInterface

import Dependencies

extension APIClient {
  public static let liveValue: APIClient = .live()

  public static func live() -> Self {
    guard let baseURL = Bundle.main.object(forInfoDictionaryKey: "BASE_URL") as? String else {
      fatalError("url missing")
    }

    actor Session {
      nonisolated let baseURL: URL
      nonisolated let token: String?

      let session: URLSession = {
        let config = URLSessionConfiguration.default
        return URLSession(configuration: config)
      }()

      let decoder: JSONDecoder = JSONDecoder()

      init(baseURL: String, token: String?) {
        self.baseURL = URL(string: "https://\(baseURL)")!
        self.token = token
      }

      public func sendRequest(
        request: APIBaseRequest,
        token: String? = nil
      ) async throws -> (
        Data,
        URLResponse
      ) {
        let urlRequest = try await request.asURLRequest(baseURL: baseURL, token: token)
        Logger.shared.log(category: .network, "API Request:\n\(dump(urlRequest))")

        let (data, response) = try await session.data(for: urlRequest)

        guard let httpResponse = response as? HTTPURLResponse else {
          let error = NetworkError.noResponseError
          Logger.shared.log(level: .error, category: .network, "API Error:\n\(dump(error))")
          throw error
        }

        guard (200...299).contains(httpResponse.statusCode) else {
          let error = NetworkError.apiError(String(data: data, encoding: .utf8) ?? "Unknown API Error")
          Logger.shared.log(level: .error, category: .network, "API Error:\n\(dump(error))")
          throw error
        }
        return (data, response)
      }
    }

    let session = Session(baseURL: baseURL, token: "")

    return .init(
      apiRequest: { request, token in
        try await session.sendRequest(request: request, token: token)
      }
    )
  }

}
