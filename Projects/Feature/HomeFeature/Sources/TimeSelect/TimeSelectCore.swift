//
//  TimeSelectCore.swift
//  HomeFeature
//
//  Created by devMinseok on 8/13/24.
//  Copyright © 2024 PomoNyang. All rights reserved.
//

import Foundation

import FeedbackGeneratorClientInterface
import PomodoroServiceInterface
import UserDefaultsClientInterface
import APIClientInterface
import DatabaseClientInterface

import ComposableArchitecture

@Reducer
public struct TimeSelectCore {
  @ObservableState
  public struct State: Equatable {
    let mode: Mode
    var timeList: [TimeItem] = []
    var selectedTime: TimeItem?
    var selectedCategory: PomodoroCategory?
    
    public init(mode: Mode) {
      self.mode = mode
    }
    
    var isTimeChanged: Bool {
      switch mode {
      case .focus:
        return selectedCategory?.focusTimeMinutes != selectedTime?.minute
      case .rest:
        return selectedCategory?.restTimeMinutes != selectedTime?.minute
      }
    }
  }
  
  public enum Action {
    case onAppear
    case pickerSelection(TimeItem?)
    case setSelectedCategory(PomodoroCategory?)
    case bottomCheckButtonTapped
  }
  
  public enum Mode {
    case focus
    case rest
  }
  
  @Dependency(FeedbackGeneratorClient.self) var feedbackGeneratorClient
  @Dependency(UserDefaultsClient.self) var userDefaultsClient
  @Dependency(DatabaseClient.self) var databaseClient
  @Dependency(APIClient.self) var apiClient
  @Dependency(PomodoroService.self) var pomodoroService
  @Dependency(\.dismiss) var dismiss
  
  public init() {}
  
  public var body: some ReducerOf<Self> {
    Reduce(self.core)
  }
  
  private func core(state: inout State, action: Action) -> EffectOf<Self> {
    switch action {
    case .onAppear:
      switch state.mode {
      case .focus:
        state.timeList = generateFocusTimeByMinute().map { TimeItem(minute: $0) }
      case .rest:
        state.timeList = generateRestTimeByMinute().map { TimeItem(minute: $0) }
      }
      return .run { send in
        let selectedCategory = try await self.pomodoroService.getSelectedCategory(
          userDefaultsClient: self.userDefaultsClient,
          databaseClient: self.databaseClient
        )
        await send(.setSelectedCategory(selectedCategory))
      }
      
    case let .pickerSelection(selection):
      state.selectedTime = selection
      return .run { _ in
        await self.feedbackGeneratorClient.impactOccurred(.light)
      }
      
    case let .setSelectedCategory(category):
      state.selectedCategory = category
      if let category {
        switch state.mode {
        case .focus:
          state.selectedTime = TimeItem(minute: category.focusTimeMinutes)
        case .rest:
          state.selectedTime = TimeItem(minute: category.restTimeMinutes)
        }
      } else {
        state.selectedTime = state.timeList.last
      }
      return .none
      
    case .bottomCheckButtonTapped:
      let mode = state.mode
      let selectedCategory = state.selectedCategory
      let selectedTime = state.selectedTime
      let isTimeChanged = state.isTimeChanged
      return .run { send in
        if isTimeChanged,
           let selectedCategoryID = selectedCategory?.id,
           let selectedTime = selectedTime?.minute {
          let selectedTimeDuration = DateComponents(minute: selectedTime).to8601DurationString()
          var request: EditCategoryRequest
          
          switch mode {
          case .focus:
            request = EditCategoryRequest(focusTime: selectedTimeDuration, restTime: nil)
          case .rest:
            request = EditCategoryRequest(focusTime: nil, restTime: selectedTimeDuration)
          }
          
          // TODO: - 오프라인 대응 필요
          try? await self.pomodoroService.changeCategoryTime(
            apiClient: self.apiClient,
            categoryID: selectedCategoryID,
            request: request
          )
        }
        
        await self.dismiss()
      }
    }
  }
  
  /// 집중시간 리스트 생성 (분)
  private func generateFocusTimeByMinute() -> [Int] {
    var result: [Int] = []
    for i in stride(from: 10, through: 60, by: 5) {
      result.append(i)
    }
    return result.reversed()
  }
  
  /// 휴식시간 리스트 생성 (분)
  private func generateRestTimeByMinute() -> [Int] {
    var result: [Int] = []
    for i in stride(from: 5, through: 30, by: 5) {
      result.append(i)
    }
    return result.reversed()
  }
}
