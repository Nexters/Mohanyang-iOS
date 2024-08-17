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

}
