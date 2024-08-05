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
  case getToken(_ deviceId: String)
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
    case let .getToken(deviceId):
      let dto = AuthDTO.Request.GetTokenRequestDTO(deviceId: deviceId)
      return .body(dto)
    case let .refreshToken(refreshToken):
      let dto = AuthDTO.Request.RefreshTokenRequestDTO(refreshToken: refreshToken)
      return .body(dto)
    }
  }
}
