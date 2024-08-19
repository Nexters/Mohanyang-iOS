//
//  UserDTO.swift
//  UserService
//
//  Created by 김지현 on 8/16/24.
//  Copyright © 2024 PomoNyang. All rights reserved.
//

import Foundation

public enum UserDTO {
  public enum Request { }
  public enum Response { }
}

public extension UserDTO.Request {
  struct SelectCatRequestDTO: Encodable {
    public var catNo: Int
  }
}

public extension UserDTO.Response {
  struct GetUserInfoResponseDTO: Decodable {
    public var registeredDeviceNo: Int
    public var isPushEnabled: Bool
    public var cat: Cat
  }

  struct Cat: Decodable {
    public var no: Int
    public var name: String
    public var type: String
  }
}
