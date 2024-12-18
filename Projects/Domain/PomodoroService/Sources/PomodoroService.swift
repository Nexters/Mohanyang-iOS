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
        apiClient, databaseClient in
        let api = CategoryAPI.getCategoryList
        let categoryList = try await apiClient.apiRequest(request: api, as: [PomodoroCategory].self)
        for category in categoryList {
          try await databaseClient.create(object: category)
        }
      },
      getCategoryList: { databaseClient in
        try await databaseClient.read(PomodoroCategory.self)
      },
      changeSelectedCategory: { userDefaultsClient, categoryID in
        await userDefaultsClient.setInteger(categoryID, key: selectedCategoryKey)
      },
      getSelectedCategory: { userDefaultsClient, databaseClient in
        let selectedCategoryID = userDefaultsClient.integerForKey(selectedCategoryKey)
        let results = try await databaseClient.read(PomodoroCategory.self, predicateFormat: "#no == %d", args: selectedCategoryID)
        return results.first
      },
      changeCategoryTime: { apiClient, categoryID, request in
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
      registerTimerOverTime: { bgTaskClient, liveActivityClient in
//        bgTaskClient.registerTask(
//          identifier: "com.pomonyang.mohanyang.update_LiveActivity",
//          queue: nil
//        ) { task in
//          print("BackgroundTask 호출!!")
//          task.expirationHandler = {
//            print("BackgroundTask 끝!!")
//            task.setTaskCompleted(success: false)
//          }
//          Task {
//            await liveActivityClient.protocolAdapter.endAllActivityImmediately(type: PomodoroActivityAttributes.self)
//            task.setTaskCompleted(success: true)
//          }
          
//          let category = PomodoroCategory(no: 507, baseCategoryCode: .study, title: "작업", position: 3, focusTime: "PT1H", restTime: "PT15M")
//          do {
//            try liveActivityClient.protocolAdapter.startActivity(
//              attributes: PomodoroActivityAttributes(),
//              content: .init(
//                state: .init(category: category, goalDatetime: Date().addingTimeInterval(1000), isRest: false),
//                staleDate: nil
//              ),
//              pushType: nil
//            )
//          } catch {
//            print("startActivity fail")
//          }
//          task.setTaskCompleted(success: true)
        }
      },
      registerTimerEnd: { bgTaskClient, liveActivityClient in
        bgTaskClient.registerTask(
          identifier: "com.pomonyang.mohanyang.update_LiveActivity",
          queue: nil
        ) { task in
          task.expirationHandler = {}
          task.setTaskCompleted(success: true)
        }
      }
    )
  }
}
