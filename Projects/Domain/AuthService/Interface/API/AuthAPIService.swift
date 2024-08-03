//
//  AuthService.swift
//  AuthService
//
//  Created by 김지현 on 8/3/24.
//  Copyright © 2024 PomoNyang. All rights reserved.
//

import Foundation
import APIClientInterface

public enum AuthAPIService {
  case getToken(_ deviceID: String)
  case refreshToken(_ refreshToken: String)
}

extension AuthAPIService: TargetType {
  public var baseURL: String {
    return API.apiBaseURL
  }

  public var path: String {
    switch self {
    case .getToken:
      return "/papi/v1/tokens"
    case .refreshToken:
      return "/papi/v1/tokens/refresh"
    }
  }

  public var method: HTTPMethod {
    switch self {
    case .getToken, .refreshToken:
      return .post
    }
  }

  public var parameters: RequestParams {
    switch self {
    case let .getToken(deviceID):
      return .body(deviceID)
    case let .refreshToken(refreshToken):
      return .body(refreshToken)
    }
  }
}
