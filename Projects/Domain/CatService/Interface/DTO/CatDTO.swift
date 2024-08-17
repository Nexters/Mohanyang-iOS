//
//  CatDTO.swift
//  CatServiceInterface
//
//  Created by 김지현 on 8/17/24.
//  Copyright © 2024 PomoNyang. All rights reserved.
//

import Foundation

public typealias CatList = [CatDTO.Response.GetCatListResponseDTO]

public enum CatDTO {
  public enum Request { }
  public enum Response { }
}

public extension CatDTO.Request {
  struct ChangeCatNameRequestDTO: Encodable {
    public var name: String
  }
}

public extension CatDTO.Response {
  struct GetCatListResponseDTO: Equatable, Decodable {
    public var no: Int
    public var name: String
    public var type: String
  }
}
