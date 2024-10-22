//
//  UserAPIRequest.swift
//  UserService
//
//  Created by 김지현 on 8/16/24.
//  Copyright © 2024 PomoNyang. All rights reserved.
//

import Foundation
import APIClientInterface

public enum UserAPIrequest {
  case selectCat(request: SelectCatRequest)
  case getUserInfo
}

extension UserAPIrequest: APIBaseRequest {
  public var baseURL: String {
    return API.apiBaseHost
  }

  public var path: String {
    switch self {
    case .selectCat:
      return "/api/v1/users/cats"
      
    case .getUserInfo:
      return "/api/v1/users/me"
    }
  }

  public var method: HTTPMethod {
    switch self {
    case .selectCat:
      return .put
      
    case .getUserInfo:
      return .get
    }
  }

  public var parameters: RequestParams {
    switch self {
    case let .selectCat(request):
      return .body(request)
      
    case .getUserInfo:
      return .requestPlain
    }
  }
}
