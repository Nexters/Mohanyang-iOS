//
//  CategorySelectCore.swift
//  HomeFeature
//
//  Created by devMinseok on 8/13/24.
//  Copyright © 2024 PomoNyang. All rights reserved.
//

import PomodoroServiceInterface
import DatabaseClientInterface

import ComposableArchitecture

@Reducer
public struct CategorySelectCore {
  @ObservableState
  public struct State: Equatable {
    var selectedCategory: PomodoroCategory?
    var categoryList: [PomodoroCategory] = []
    
    public init() {}
  }
  
  public enum Action {
    case onAppear
    case dismissButtonTapped
    case bottomCheckButtonTapped
    
    case getCategoryListResponse(Result<[PomodoroCategory], Error>)
    
    case selectCategory(PomodoroCategory)
  }
  
  @Dependency(PomodoroService.self) var pomodoroService
  @Dependency(DatabaseClient.self) var databaseClient
  
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
      }
      
    case .dismissButtonTapped:
      return .none
      
    case .bottomCheckButtonTapped:
      return .none
      
    case let .getCategoryListResponse(.success(response)):
      state.categoryList = response
      return .none
      
    case .getCategoryListResponse(.failure):
      return .none
      
    case let .selectCategory(category):
      state.selectedCategory = category
      return .none
    }
  }
}
