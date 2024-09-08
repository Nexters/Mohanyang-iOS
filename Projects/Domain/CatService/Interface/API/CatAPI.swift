//
//  CatAPIRequest.swift
//  CatServiceInterface
//
//  Created by 김지현 on 8/17/24.
//  Copyright © 2024 PomoNyang. All rights reserved.
//

import APIClientInterface

@_spi(Internal)
public enum CatAPI {
  case fetchCatList
  case changeCatName(request: ChangeCatNameRequest)
}

extension CatAPI: APIBaseRequest {
  public var baseURL: String {
    return API.apiBaseHost
  }
  
  public var path: String {
    switch self {
    case .fetchCatList:
      return "/api/v1/cats"
      
    case .changeCatName:
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
      
    case let .changeCatName(request):
      return .body(request)
    }
  }
}
