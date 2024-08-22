//
//  UserAPIClientInterface.swift
//  UserService
//
//  Created by 김지현 on 8/16/24.
//  Copyright © 2024 PomoNyang. All rights reserved.
//

import APIClientInterface
import DatabaseClientInterface

import Dependencies
import DependenciesMacros

@DependencyClient
public struct UserService {
  public var selectCat: @Sendable (_ apiClient: APIClient, _ request: SelectCatRequest) async throws -> Void
  public var syncUserInfo: @Sendable (_ apiClient: APIClient, _ databaseClient: DatabaseClient) async throws -> Void
  public var getUserInfo: @Sendable (_ databaseClient: DatabaseClient) async throws -> User?
}

extension UserService: TestDependencyKey {
  public static let previewValue = Self()
  public static let testValue = Self()
}
