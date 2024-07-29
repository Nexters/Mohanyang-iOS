//
//  AccessTokenInterceptorInterface.swift
//  APIClient
//
//  Created by 김지현 on 7/29/24.
//  Copyright © 2024 PomoNyang. All rights reserved.
//

import Foundation
import KeychainClientInterface

public protocol AccessTokenInterceptorInterface {
  // adapt, retry 각각 매개변수로 받을지, 프로토콜 변수로 놓을지 고민
  var keychainClient: KeychainClient { get }
  func adapt(_ request: URLRequest) async throws -> URLRequest
  func retry(_ request: URLRequest, dueTo error: Error) async -> Bool
}
