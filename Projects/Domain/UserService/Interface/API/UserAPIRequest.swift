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
  case getCatList
}

extension UserAPIrequest: APIBaseRequest {
  public var baseURL: String {
    return API.apiBaseURL
  }

  public var path: String {
    switch self {
    case .getCatList:
      return "/api/v1/cats"
    }
  }

  public var method: HTTPMethod {
    switch self {
    case .getCatList:
      return .get
    }
  }

  public var parameters: RequestParams {
    switch self {
    case .getCatList:
      return .requestPlain
    }
  }
}
