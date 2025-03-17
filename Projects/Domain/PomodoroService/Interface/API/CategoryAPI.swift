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
  case selectCategory(id: Int)
  case addCategory(request: AddCategoryRequest)
  case editCategory(id: Int, request: EditCategoryRequest)
  case deleteCategory(id: Int)
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

    case let .selectCategory(id):
      return "/api/v1/categories/select/\(id)"

    case .addCategory:
      return "/api/v1/categories"

    case let .editCategory(id, _):
      return "/api/v1/categories/\(id)"

    case let .deleteCategory(id):
      return "/api/v1/categories/\(id)"

    case .getCategoryList:
      return "/api/v1/categories"
    }
  }
  
  public var method: HTTPMethod {
    switch self {
    case .getCategory:
      return .get

    case .selectCategory:
      return .patch

    case .addCategory:
      return .post

    case .editCategory:
      return .patch

    case .deleteCategory:
      return .delete

    case .getCategoryList:
      return .get
    }
  }
  
  public var parameters: RequestParams {
    switch self {
    case .getCategory:
      return .requestPlain

    case .selectCategory:
      return .requestPlain

    case let .addCategory(request: request):
      return .body(request)

    case let .editCategory(_, request):
      return .body(request)

    case .deleteCategory:
      return .requestPlain

    case .getCategoryList:
      return .requestPlain
    }
  }
}
