//
//  APIRequestLoader.swift
//  APIClientInterface
//
//  Created by 김지현 on 7/24/24.
//  Copyright © 2024 PomoNyang. All rights reserved.
//

import Foundation
import APIClientInterface
import KeychainClientInterface

public class APIRequestLoader<T: TargetType>: APIRequestLoaderInterface {
  let coniguration: URLSessionConfiguration
  let session: URLSession

  public init(configuration: URLSessionConfiguration = .default) {
    self.coniguration = configuration
#if PROD
    self.session = URLSession(configuration: configuration)
#elseif DEV
    let sessionDelegate = EventLoggerDelegate()
    self.session = URLSession(configuration: configuration, delegate: sessionDelegate)
#endif

    // TODO: token interceptor
  }

  public func fetchData<M: Decodable>(
    target: T,
    responseData: M.Type,
    keychainClient: KeychainClient
  ) async throws -> M {
    let urlRequest = try await target.asURLRequest(keychainClient: keychainClient)
    
    let (data, response) = try await session.data(for: urlRequest)

    guard let httpResponse = response as? HTTPURLResponse else {
      throw NetworkError.noResponseError
    }

    switch httpResponse.statusCode {
    case 200..<300:
      do {
        let decodedData = try JSONDecoder().decode(responseData, from: data)
        return decodedData
      } catch {
        throw NetworkError.decodingError
      }
    case 401: // token interceptor 예정
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
