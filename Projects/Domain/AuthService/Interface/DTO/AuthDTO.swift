//
//  AuthDTO.swift
//  AuthService
//
//  Created by 김지현 on 8/3/24.
//  Copyright © 2024 PomoNyang. All rights reserved.
//

import Foundation

public enum AuthDTO {
  public enum Request { }
  public enum Response { }
}

public extension AuthDTO.Request {
  struct GetTokenRequestDTO: Encodable {
    public var deviceId: String
  }

  struct RefreshTokenRequestDTO: Encodable {
    public var refreshToken: String
  }
}

public extension AuthDTO.Response {
  struct TokenResponseDTO: Decodable {
    public var accessToken: String
    public var accessTokenExpiredAt: String
    public var refreshToken: String
    public var refreshTokenExpiredAt: String
  }
}
