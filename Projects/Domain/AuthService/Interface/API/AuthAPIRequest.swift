//
//  AuthService.swift
//  AuthService
//
//  Created by 김지현 on 8/3/24.
//  Copyright © 2024 PomoNyang. All rights reserved.
//

import Foundation
import APIClientInterface

public enum AuthAPIRequest {
  case login(_ deviceId: String)
}

extension AuthAPIRequest: APIBaseRequest {
  public var baseURL: String {
    return API.apiBaseURL
  }
  
  public var path: String {
    switch self {
    case .login:
      return "/papi/v1/tokens"
    }
  }

  public var method: HTTPMethod {
    switch self {
    case .login:
      return .post
    }
  }

  public var parameters: RequestParams {
    switch self {
    case let .login(deviceId):
      let dto = AuthDTO.Request.GetTokenRequestDTO(deviceId: deviceId)
      return .body(dto)
    }
  }
}
