//
//  PomodoroServiceInterface.swift
//  PomodoroService
//
//  Created by devMinseok on 8/17/24.
//

import UserDefaultsClientInterface
import DatabaseClientInterface
import APIClientInterface

import Dependencies
import DependenciesMacros

@DependencyClient
public struct PomodoroService {
  public var syncCategoryList: @Sendable (_ apiClient: APIClient, _ databaseClient: DatabaseClient) async throws -> Void
  public var getCategoryList: @Sendable (_ databaseClient: DatabaseClient) async throws -> [PomodoroCategory]
  public var changeSelectedCategory: @Sendable (_ userDefaultsClient: UserDefaultsClient, _ categoryID: Int) async -> Void
  public var getSelectedCategory: @Sendable (_ userDefaultsClient: UserDefaultsClient, _ databaseClient: DatabaseClient) async throws -> PomodoroCategory?
}

extension PomodoroService: TestDependencyKey {
  public static let previewValue = Self()
  public static let testValue = Self()
}
