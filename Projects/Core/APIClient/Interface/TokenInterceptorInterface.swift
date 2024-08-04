//
//  AccessTokenInterceptorInterface.swift
//  APIClient
//
//  Created by 김지현 on 7/29/24.
//  Copyright © 2024 PomoNyang. All rights reserved.
//

import Foundation
import KeychainClientInterface

public protocol TokenInterceptorInterface {
  var session: URLSession { get }
  var keychainClient: KeychainClient { get }
  func adapt(_ request: URLRequest) async throws -> URLRequest
  func retry(_ request: URLRequest, dueTo error: Error) async -> Bool
}
