//
//  UserService.swift
//  UserService
//
//  Created by 김지현 on 8/16/24.
//  Copyright © 2024 PomoNyang. All rights reserved.
//

import Foundation

import APIClientInterface
import UserServiceInterface

import Dependencies

extension UserService: DependencyKey {
  public static let liveValue: UserService = .live()
  private static func live() -> Self {
    return UserService(
      selectCat: { apiClient, request in
        let api = UserAPIrequest.selectCat(request: request)
        _ = try await apiClient.apiRequest(
          request: api,
          as: EmptyResponse.self
        )
      },
      syncUserInfo: { apiClient, databaseClient in
        let api = UserAPIrequest.getUserInfo
        let userInfo = try await apiClient.apiRequest(request: api, as: User.self)
        try await databaseClient.create(object: userInfo)
      },
      getUserInfo: { databaseClient in
        return try await databaseClient.read(User.self).first
      }
    )
  }
}
