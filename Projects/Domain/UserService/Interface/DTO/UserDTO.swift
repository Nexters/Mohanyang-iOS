//
//  UserDTO.swift
//  UserService
//
//  Created by 김지현 on 8/16/24.
//  Copyright © 2024 PomoNyang. All rights reserved.
//

import Foundation

public typealias CatList = [UserDTO.Response.GetCatListResponseDTO]

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
  struct GetCatListResponseDTO: Equatable, Decodable {
    public var no: Int
    public var name: String
    public var type: String
  }

  struct SelectCatResponseDTO: Decodable { }
}
