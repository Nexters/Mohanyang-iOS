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

extension APIClient: DependencyKey {
  public static let liveValue: APIClient = .live()

  public static func live() -> Self {

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

      func sendRequest(
        _ request: APIBaseRequest,
        isWithInterceptor: Bool,
        retryCnt: Int = 0
      ) async throws -> (Data, URLResponse) {
        guard retryCnt < 3 else { throw throwNetworkErr(.timeOutError) }

        var urlRequest = try await request.asURLRequest()
        if isWithInterceptor {
          urlRequest = try await tokenInterceptor.adapt(urlRequest)
        }
        Logger.shared.log(category: .network, urlRequest.asRequestLog())

        let (data, response) = try await session.data(for: urlRequest)

        guard let httpResponse = response as? HTTPURLResponse else {
          let error = NetworkError.noResponseError
          Logger.shared.log(level: .error, category: .network, "API Error:\n\(dump(error))")
          throw error
        }

        switch httpResponse.statusCode {
        case 200..<300:
          Logger.shared.log(category: .network, urlRequest.asResponseLog(data, httpResponse))
          return (data, response)
        case 401:
          try await tokenInterceptor.retry(for: self.session)
          return try await sendRequest(request, isWithInterceptor: isWithInterceptor, retryCnt: retryCnt + 1)
        case 400..<500:
          throw throwNetworkErr(.requestError("bad request"))
        case 500..<600:
          throw throwNetworkErr(.serverError)
        default:
          throw throwNetworkErr(.unknownError)
        }

        func throwNetworkErr(_ error: NetworkError) -> NetworkError {
          Logger.shared.log(level: .error, category: .network, "\(error.localizedDescription):\n\(dump(error))")
          return error
        }
      }
    }

    let tokenInterceptor = TokenInterceptor()
    let session = Session(tokenInterceptor: tokenInterceptor)

    return .init(
      apiRequest: { request, isWithInterceptor in
        return try await session.sendRequest(request, isWithInterceptor: isWithInterceptor)
      }
    )
  }
}
