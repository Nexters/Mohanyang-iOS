//
//  StatisticAPI.swift
//  PomodoroService
//
//  Created by devMinseok on 7/20/25.
//  Copyright © 2025 PomoNyang. All rights reserved.
//

import APIClientInterface

@_spi(Internal)
public enum StatisticAPI {
  case getStatistics(date: String)
}

extension StatisticAPI: APIBaseRequest {
  public var baseURL: String {
    return API.apiBaseHost
  }

  public var path: String {
    switch self {
    case let .getStatistics(date):
      return "/api/v1/statistics/\(date)"
    }
  }

  public var method: HTTPMethod {
    switch self {
    case .getStatistics:
      return .get
    }
  }

  public var parameters: RequestParams {
    switch self {
    case .getStatistics:
      return .requestPlain
    }
  }
}
