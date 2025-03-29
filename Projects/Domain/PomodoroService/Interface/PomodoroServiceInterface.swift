//
//  PomodoroServiceInterface.swift
//  PomodoroService
//
//  Created by devMinseok on 8/17/24.
//

import UserDefaultsClientInterface
import DatabaseClientInterface
import APIClientInterface
import BackgroundTaskClientInterface
import LiveActivityClientInterface

import Dependencies
import DependenciesMacros

@DependencyClient
public struct PomodoroService {
  public var syncCategoryList: @Sendable (_ apiClient: APIClient, _ userDefaultsClient: UserDefaultsClient, _ databaseClient: DatabaseClient) async throws -> Void
  public var getCategoryList: @Sendable (_ databaseClient: DatabaseClient) async throws -> [PomodoroCategory]
  public var changeSelectedCategory: @Sendable (_ apiClient: APIClient, _ userDefaultsClient: UserDefaultsClient, _ categoryID: Int) async throws -> Void
  public var getSelectedCategory: @Sendable (_ userDefaultsClient: UserDefaultsClient, _ databaseClient: DatabaseClient) async throws -> PomodoroCategory?
  public var editCategory: @Sendable (_ apiClient: APIClient, _ categoryID: Int, _ request: EditCategoryRequest) async throws -> Void
  public var saveFocusTimeHistory: @Sendable (_ apiClient: APIClient, _ databaseClient: DatabaseClient, _ request: [FocusTimeHistory]) async throws -> Void
  public var getFocusTimeSummaries: @Sendable (_ apiClient: APIClient) async throws -> FocusTimeSummary
  public var addCategory: @Sendable (_ apiClient: APIClient, _ request: AddCategoryRequest) async throws -> Void
  public var deleteCategories: @Sendable (_ apiClient: APIClient, _ request: DeleteCategoryRequest) async throws -> Void

  public var registerBGTaskToUpdateTimer: @Sendable (_ bgTaskClient: BackgroundTaskClient, _ liveActivityClient: LiveActivityClient) -> Bool = { _, _ in false }
}

extension PomodoroService: TestDependencyKey {
  public static let previewValue = Self()
  public static let testValue = Self()
}
