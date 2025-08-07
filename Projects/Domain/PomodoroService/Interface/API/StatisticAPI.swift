//
//  StatisticAPI.swift
//  PomodoroService
//
//  Created by devMinseok on 7/20/25.
//  Copyright © 2025 PomoNyang. All rights reserved.
//

import Foundation

import APIClientInterface

@_spi(Internal)
public enum StatisticAPI {
  case getStatistics(date: Date)
}

extension StatisticAPI: APIBaseRequest {
  public var baseURL: String {
    return API.apiBaseHost
  }

  public var path: String {
    switch self {
    case let .getStatistics(date):
      let dateString = date.toString(format: .yyyy_MM_dd)
      return "/api/v1/statistics/\(dateString)"
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
