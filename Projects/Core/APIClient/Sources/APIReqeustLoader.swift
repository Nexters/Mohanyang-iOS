//
//  APIReqeustLoader.swift
//  APIClientInterface
//
//  Created by 김지현 on 8/3/24.
//  Copyright © 2024 PomoNyang. All rights reserved.
//
// MARK: CAT-98 : token interceptor 진행중 (8.4)
import Foundation
import APIClientInterface
import KeychainClientInterface

open class APIRequestLoader<T: TargetType> {

  public var session: URLSession
  public var urlConfiguration: URLSessionConfiguration
  public var keychainClient: KeychainClient
  //public var tokenInterceptor: TokenInterceptor

  public init(
    configuration: URLSessionConfiguration = .default,
    keychainClient: KeychainClient
  ) {
    self.urlConfiguration = configuration
    self.keychainClient = keychainClient
#if PROD
    self.session = URLSession(configuration: configuration)
#elseif DEV
    let sessionDelegate = EventLoggerDelegate()
    self.session = URLSession(configuration: configuration, delegate: sessionDelegate, delegateQueue: nil)
#endif
    //self.tokenInterceptor = TokenInterceptor(session: self.session, keychainClient: keychainClient)
  }

  public func fetchData<M: Decodable>(
    target: T,
    responseData: M.Type,
    isWithInterceptor: Bool = true,
    keychainClient: KeychainClient
  ) async throws -> M {
    let urlRequest = try await target.asURLRequest(keychainClient: keychainClient)

    /*
     let session = isWithInterceptor ? ~~
     */
    let (data, response) = try await session.data(for: urlRequest)

    guard let httpResponse = response as? HTTPURLResponse else {
      throw NetworkError.noResponseError
    }

    switch httpResponse.statusCode {
    case 200..<300:
      do {
        let decodedData = try JSONDecoder().decode(responseData, from: data)
        print(decodedData)
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
