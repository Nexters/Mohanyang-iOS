//
//  NetworkError.swift
//  APIClientInterface
//
//  Created by 김지현 on 7/23/24.
//  Copyright © 2024 PomoNyang. All rights reserved.
//

import Foundation

public enum NetworkError: Error, Equatable {
  case requestError(_ description: String)
  case apiError(_ description: String)
  case noResponseError
  case authorizationError
  case decodingError
  case serverError
  case networkConnectionError
  case timeOutError
  case unknownError
  case refreshTokenExpired

  public var errorMessage: String {
    switch self {
    case let .requestError(description):
      return "Request Error: \(description)"
    case let .apiError(description):
      return "API Error: \(description)"
    case .decodingError:
      return "Decoding Error"
    case .serverError:
      return "Server Error"
    case .networkConnectionError:
      return "Network Connection Error"
    case .timeOutError:
      return "Timeout Error"
    case .unknownError:
      return "Unknown Error"
    case .noResponseError:
      return "No Response Error"
    case .authorizationError:
      return "Autorization Error"
    case .refreshTokenExpired:
      return "Refresh Token has been expired Error"
    }
  }
}
