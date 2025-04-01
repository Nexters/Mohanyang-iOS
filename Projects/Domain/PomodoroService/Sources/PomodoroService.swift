//
//  PomodoroService.swift
//  PomodoroService
//
//  Created by devMinseok on 8/17/24.
//

@_spi(Internal)
import PomodoroServiceInterface
import APIClientInterface
import Foundation

import Dependencies

let selectedCategoryKey = "userdefaults_key_selected_category"

extension PomodoroService: DependencyKey {
  public static let liveValue: PomodoroService = .live()
  
  private static func live() -> PomodoroService {
    return .init(
      syncCategoryList: {
        apiClient, userDefaultsClient, databaseClient in
        let api = CategoryAPI.getCategoryList
        let categoryList = try await apiClient.apiRequest(request: api, as: [PomodoroCategory].self)

        if let selectedCategory = categoryList.first(where: { $0.isSelected }) {
          await userDefaultsClient.setInteger(selectedCategory.id, key: selectedCategoryKey)
        }

        for category in categoryList {
          try await databaseClient.create(object: category)
        }
      },
      getCategoryList: { databaseClient in
        try await databaseClient.read(PomodoroCategory.self)
      },
      changeSelectedCategory: { apiClient, userDefaultsClient, categoryID in
        let api = CategoryAPI.selectCategory(id: categoryID)
        _ = try await apiClient.apiRequest(request: api, as: EmptyResponse.self)
        await userDefaultsClient.setInteger(categoryID, key: selectedCategoryKey)
      },
      // TODO: 데이터베이스 저장 여부 민석과 논의 필요
      getSelectedCategory: { userDefaultsClient, databaseClient in
        let selectedCategoryID = userDefaultsClient.integerForKey(selectedCategoryKey)
        let results = try await databaseClient.read(PomodoroCategory.self, predicateFormat: "#no == %d", args: selectedCategoryID)
        return results.first
      },
      editCategory: { apiClient, categoryID, request in
        let api = CategoryAPI.editCategory(id: categoryID, request: request)
        _ = try await apiClient.apiRequest(request: api, as: EmptyResponse.self)
      },
      saveFocusTimeHistory: { apiClient, databaseClient, request in
        for focusTime in request {
          try await databaseClient.create(object: focusTime)
        }
        let api = FocusTimeAPI.saveFocusTimes(request: request)
        _ = try await apiClient.apiRequest(request: api, as: EmptyResponse.self)
      },
      getFocusTimeSummaries: { apiClient in
        let api = FocusTimeAPI.getSummaries
        return try await apiClient.apiRequest(request: api, as: FocusTimeSummary.self)
      },
      addCategory: { apiClient, request in
        let api = CategoryAPI.addCategory(request: request)
        _ = try await apiClient.apiRequest(request: api, as: EmptyResponse.self)
      },
      deleteCategories: { apiClient, databaseClient, ids in
        let api = CategoryAPI.deleteCategory(request: .init(no: ids))
        _ = try await apiClient.apiRequest(request: api, as: EmptyResponse.self)
        try await databaseClient.delete(PomodoroCategory.self, predicateFormat: "#no in %d", args: ids)
      },
      registerBGTaskToUpdateTimer: { bgTaskClient, liveActivityClient in
        bgTaskClient.registerTask(
          identifier: "com.pomonyang.mohanyang.update_LiveActivity",
          queue: nil
        ) { task in
          task.expirationHandler = {
            task.setTaskCompleted(success: false)
          }
          let pomodoroActivities = liveActivityClient.protocolAdapter.getActivities(type: PomodoroActivityAttributes.self)
          Task {
            if let firstActivity = pomodoroActivities.first {
              await firstActivity.update(firstActivity.content)
            }
            task.setTaskCompleted(success: true)
          }
        }
      }
    )
  }
}
