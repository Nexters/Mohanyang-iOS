//
//  CatAPIRequest.swift
//  CatServiceInterface
//
//  Created by 김지현 on 8/17/24.
//  Copyright © 2024 PomoNyang. All rights reserved.
//

import Foundation
import APIClientInterface

public enum CatAPIrequest {
  case fetchCatList, changeCatName(String)
}

extension CatAPIrequest: APIBaseRequest {
  public var baseURL: String {
    return API.apiBaseURL
  }

  public var path: String {
    switch self {
    case .fetchCatList, .changeCatName:
      return "/api/v1/cats"
    }
  }

  public var method: HTTPMethod {
    switch self {
    case .fetchCatList:
      return .get
    case.changeCatName:
      return .put
    }
  }

  public var parameters: RequestParams {
    switch self {
    case .fetchCatList:
      return .requestPlain
    case .changeCatName(let name):
      let dto = CatDTO.Request.ChangeCatNameRequestDTO(name: name)
      return .body(dto)
    }
  }
}
