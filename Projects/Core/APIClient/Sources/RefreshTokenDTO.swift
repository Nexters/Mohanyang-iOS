//
//  RefreshAccessTokenService.swift
//  APIClient
//
//  Created by 김지현 on 8/7/24.
//  Copyright © 2024 PomoNyang. All rights reserved.
//

import Foundation

struct RefreshTokenRequestDTO: Encodable {
  public var refreshToken: String
}
struct TokenResponseDTO: Decodable {
  public var accessToken: String
  public var accessTokenExpiredAt: String
  public var refreshToken: String
  public var refreshTokenExpiredAt: String
}
