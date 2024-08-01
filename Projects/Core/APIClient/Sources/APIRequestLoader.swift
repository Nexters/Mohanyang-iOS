//
//  APIRequestLoader.swift
//  APIClient
//
//  Created by 김지현 on 8/1/24.
//  Copyright © 2024 PomoNyang. All rights reserved.
//

import Foundation
import KeychainClientInterface
import APIClientInterface
import DIContainer

struct APIRequestLoaderKey: InjectionKey {
    typealias Value = APIRequestLoaderInterface
}

struct APIRequestLoader<T: TargetType>: APIRequestLoaderInterface, Injectable {
  public var session: URLSession

  public var urlConfiguration: URLSessionConfiguration

  public var keychainClient: KeychainClientInterface.KeychainClient

  public var tokenInterceptor: TokenInterceptor


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
