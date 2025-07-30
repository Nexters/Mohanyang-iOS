//
//  FocusTimeAPI.swift
//  PomodoroServiceInterface
//
//  Created by devMinseok on 8/20/24.
//  Copyright © 2024 PomoNyang. All rights reserved.
//

import APIClientInterface

@_spi(Internal)
public enum FocusTimeAPI {
  case saveFocusTimes(request: [FocusTimeHistory])
}

extension FocusTimeAPI: APIBaseRequest {
  public var baseURL: String {
    return API.apiBaseHost
  }
  
  public var path: String {
    switch self {
    case .saveFocusTimes:
      return "/api/v2/focus-times"
    }
  }
  
  public var method: HTTPMethod {
    switch self {
    case .saveFocusTimes:
      return .post
    }
  }
  
  public var parameters: RequestParams {
    switch self {
    case let .saveFocusTimes(request):
      return .body(request)
    }
  }
}
