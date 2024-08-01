//
//  NetworkProvider.swift
//  APIClientInterface
//
//  Created by 김지현 on 7/24/24.
//  Copyright © 2024 PomoNyang. All rights reserved.
//

import Foundation
import KeychainClientInterface

public protocol APIRequestLoaderInterface {
  associatedtype T: TargetType
  var session: URLSession { get }
  var urlConfiguration: URLSessionConfiguration { get }
  var keychainClient: KeychainClient { get }
  var tokenInterceptor: TokenInterceptor { get }
  func fetchData<M: Decodable> (
    target: T,
    responseData: M.Type,
    keychainClient: KeychainClient
  ) async throws -> M
}
