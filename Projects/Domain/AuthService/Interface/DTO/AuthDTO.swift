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

}

public extension AuthDTO.Response {
  struct TokenResponseDTO: Decodable {
    public var accessToken: String
    public var accessTokenExpiredAt: String
    public var refreshToken: String
    public var refreshTokenExpiredAt: String
  }
}
