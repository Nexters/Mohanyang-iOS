//
//  CategorySelectCore.swift
//  HomeFeature
//
//  Created by devMinseok on 8/13/24.
//  Copyright © 2024 PomoNyang. All rights reserved.
//

import Foundation
import APIClientInterface
import PomodoroServiceInterface
import DatabaseClientInterface
import UserDefaultsClientInterface
import AnalyticsClientInterface

import ComposableArchitecture

@Reducer
public struct CategorySelectCore {
  @ObservableState
  public struct State: Equatable {
    var selectType: CategorySelectType = .select
    var selectedCategory: PomodoroCategory?
    var selectedEditCategory: PomodoroCategory?
    var selectedDeleteCategory: [Int] = []
    var categoryList: [PomodoroCategory] = [] {
      didSet {
        isCategoryAddAvailable = categoryList.count < 10
      }
    }
    var isMenuViewShow: Bool = false
    var isCategoryAddAvailable: Bool = true
    var addedCategoryCount: Int = 0

    public init() {}
  }
  
  public enum Action {
    case onAppear
    case showMenu(Bool)
    case cancelButtonTapped
    case editButtonTapped
    case deleteButtonTapped

    case getCategoryListResponse(Result<[PomodoroCategory], Error>)
    
    case setSelectedCategory(PomodoroCategory?)
    case selectCategory(PomodoroCategory)
    case selectEditCategory(PomodoroCategory)
    case selectDeleteCategory(PomodoroCategory)

    case addCategoryTapped
    case deleteCategoriesTapped([Int])
  }

  public enum CategorySelectType {
    case select, edit, delete

    var title: String {
      switch self {
      case .select: "카테고리"
      case .edit: "카테고리 수정"
      case .delete: "카테고리 삭제"
      }
    }

    var desc: String? {
      switch self {
      case .edit: "수정할 카테고리를 선택해주세요."
      default: nil
      }
    }
  }

  @Dependency(APIClient.self) var apiClient
  @Dependency(PomodoroService.self) var pomodoroService
  @Dependency(DatabaseClient.self) var databaseClient
  @Dependency(UserDefaultsClient.self) var userDefaultsClient
  @Dependency(AnalyticsClient.self) var analyticsClient
  @Dependency(\.dismiss) var dismiss
  
  public init() {}
  
  public var body: some ReducerOf<Self> {
    Reduce(self.core)
  }
  
  private func core(state: inout State, action: Action) -> EffectOf<Self> {
    switch action {
    case .onAppear:
      return .run { send in
        await send(
          .getCategoryListResponse(
            Result {
              try await self.pomodoroService.getCategoryList(
                databaseClient: databaseClient
              )
            }
          )
        )
        let selectedCategory = try await self.pomodoroService.getSelectedCategory(
          userDefaultsClient: self.userDefaultsClient,
          databaseClient: self.databaseClient
        )
        await send(.setSelectedCategory(selectedCategory))
      }

    case .showMenu(let isShow):
      state.isMenuViewShow = isShow
      return .none

    case .cancelButtonTapped:
      state.selectType = .select
      return .none

    case .editButtonTapped:
      analyticsClient.sendEvent(
        EventData(name: "category_edit_click")
      )
      state.isMenuViewShow = false
      state.selectType = .edit
      return .none

    case .deleteButtonTapped:
      state.isMenuViewShow = false
      state.selectType = .delete
      return .none

    case let .getCategoryListResponse(.success(response)):
      state.categoryList = response
      return .none
      
    case .getCategoryListResponse(.failure):
      return .none
      
    case let .setSelectedCategory(category):
      state.selectedCategory = category
      return .none
      
    case let .selectCategory(category):
      state.selectedCategory = category
      return .run { [selectedCategory = state.selectedCategory] send in
        if let selectedCategory {
          try await self.pomodoroService.changeSelectedCategory(
            apiClient: self.apiClient,
            userDefaultsClient: self.userDefaultsClient,
            categoryID: selectedCategory.id
          )
        }
        await self.dismiss()
      }

    case let .selectEditCategory(category):
      state.selectedEditCategory = category
      return .run { _ in
        await self.dismiss()
      }

    case let .selectDeleteCategory(category):
      if let existIds = state.selectedDeleteCategory.firstIndex(of: category.id) {
        state.selectedDeleteCategory.remove(at: existIds)
      } else {
        state.selectedDeleteCategory.append(category.id)
      }
      return .none

    case .addCategoryTapped:
      analyticsClient.sendEvent(
        EventData(name: "user_category_add_click")
      )
      return .run { _ in
        await self.dismiss()
      }

    case .deleteCategoriesTapped:
      analyticsClient.sendEvent(
        EventData(name: "category_delete_cta_click")
      )
      return .none
    }
  }
}
