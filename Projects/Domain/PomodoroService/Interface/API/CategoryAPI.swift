//
//  CategoryAPI.swift
//  PomodoroService
//
//  Created by devMinseok on 8/17/24.
//  Copyright © 2024 PomoNyang. All rights reserved.
//

import APIClientInterface

@_spi(Internal)
public enum CategoryAPI {
  case getCategory(id: Int)
  case editCategory(id: Int, request: EditCategoryRequest)
  case getCategoryList
}

extension CategoryAPI: APIBaseRequest {
  public var baseURL: String {
    return API.apiBaseHost
  }
  
  public var path: String {
    switch self {
    case let .getCategory(id):
      return "/api/v1/categories/\(id)"
      
    case let .editCategory(id, _):
      return "/api/v1/categories/\(id)"
      
    case .getCategoryList:
      return "/api/v1/categories"
    }
  }
  
  public var method: HTTPMethod {
    switch self {
    case .getCategory:
      return .get
      
    case .editCategory:
      return .patch
      
    case .getCategoryList:
      return .get
    }
  }
  
  public var parameters: RequestParams {
    switch self {
    case .getCategory:
      return .requestPlain
      
    case let .editCategory(_, request):
      return .body(request)
      
    case .getCategoryList:
      return .requestPlain
    }
  }
}
