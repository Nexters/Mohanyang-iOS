//
//  CategorySelectCore.swift
//  HomeFeature
//
//  Created by devMinseok on 8/13/24.
//  Copyright © 2024 PomoNyang. All rights reserved.
//

import PomodoroServiceInterface
import DatabaseClientInterface
import UserDefaultsClientInterface

import ComposableArchitecture

@Reducer
public struct CategorySelectCore {
  @ObservableState
  public struct State: Equatable {
    var selectType: CategorySelectType = .select
    var selectedCategory: PomodoroCategory?
    var categoryList: [PomodoroCategory] = [] {
      didSet {
        isCategoryAddAvailable = categoryList.count < 10
      }
    }
    var isCategoryAddAvailable: Bool = true
    public init() {}
  }
  
  public enum Action {
    case onAppear
    case moreButtonTapped
    case cancelButtonTapped

    case getCategoryListResponse(Result<[PomodoroCategory], Error>)
    
    case setSelectedCategory(PomodoroCategory?)
    case selectCategory(PomodoroCategory)

    case addCategoryTapped
  }

  public enum CategorySelectType {
    case select, edit, delete

    var title: String {
      switch self {
      case .select: return "카테고리"
      case .edit: return "카테고리 수정"
      case .delete: return "카테고리 삭제"
      }
    }
  }

  @Dependency(PomodoroService.self) var pomodoroService
  @Dependency(DatabaseClient.self) var databaseClient
  @Dependency(UserDefaultsClient.self) var userDefaultsClient
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
      
    case .moreButtonTapped:
      // TODO: 액션메뉴
      return .none

    case .cancelButtonTapped:
      state.selectType = .select
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
          await self.pomodoroService.changeSelectedCategory(
            userDefaultsClient: self.userDefaultsClient,
            categoryID: selectedCategory.id
          )
        }
        await self.dismiss()
      }

    case .addCategoryTapped:
      return .run { _ in
        await self.dismiss()
      }
    }
  }
}
