//
//  StatisticsHomeCore.swift
//  StatisticsFeature
//
//  Created by devMinseok on 7/7/25.
//  Copyright © 2025 PomoNyang. All rights reserved.
//

import Foundation

import APIClientInterface
import PomodoroServiceInterface
import DatabaseClientInterface
import UserServiceInterface

import ComposableArchitecture

@Reducer
public struct StatisticsHomeCore {
  @ObservableState
  public struct State: Equatable {
    var userInfo: User?
    var statisticsOfDate: Statistics?
    var selectedDate: Date = Date()

    public init() {

    }

    var isPrevAvailable: Bool {
      guard let createdAt = userInfo?.createdAt else { return false }
      let createdDate = Calendar.current.startOfDay(for: createdAt)
      let selectedDate = Calendar.current.startOfDay(for: selectedDate)
      return createdDate < selectedDate
    }
    var isNextAvailable: Bool {
      let nowDate = Calendar.current.startOfDay(for: Date())
      let selectedDate = Calendar.current.startOfDay(for: selectedDate)
      return nowDate > selectedDate
    }
  }

  public enum Action {
    case onAppear

    case prevDateButtonTapped
    case nextDateButtonTapped
    case setSelectedDate(Date)

    case responseGetStatistics(Result<Statistics?, Error>)
    case responseGetUserInfo(Result<User?, Error>)
  }

  @Dependency(APIClient.self) var apiClient
  @Dependency(PomodoroService.self) var pomodoroService
  @Dependency(DatabaseClient.self) var databaseClient
  @Dependency(UserService.self) var userService

  public init() {}

  public var body: some ReducerOf<Self> {
    Reduce(self.core)
  }

  private func core(state: inout State, action: Action) -> EffectOf<Self> {
    switch action {
    case .onAppear:
      let selectedDate = state.selectedDate
      return .run { send in

        await send(
          .responseGetUserInfo(
            Result {
              try await self.userService.getUserInfo(databaseClient: databaseClient)
            }
          )
        )
        await self.getStatistics(send: send, selectedDate: selectedDate)
      }

    case .prevDateButtonTapped:
      guard let prevDate = Calendar.current.date(
        byAdding: .day,
        value: -1,
        to: state.selectedDate
      ) else { return .none }
      state.selectedDate = prevDate
      return .run { send in
        await self.getStatistics(send: send, selectedDate: prevDate)
      }

    case .nextDateButtonTapped:
      guard let nextDate = Calendar.current.date(
        byAdding: .day,
        value: 1,
        to: state.selectedDate
      ) else { return .none }
      state.selectedDate = nextDate
      return .run { send in
        await self.getStatistics(send: send, selectedDate: nextDate)
      }

    case let .setSelectedDate(selectedDate):
      state.selectedDate = selectedDate
      return .none

    case let .responseGetStatistics(.success(response)):
      state.statisticsOfDate = response
      return .none

    case .responseGetStatistics(.failure):
      return .none

    case let .responseGetUserInfo(.success(response)):
      state.userInfo = response
      return .none

    case .responseGetUserInfo(.failure):
      return .none
    }
  }

  func getStatistics(
    send: Send<StatisticsHomeCore.Action>,
    selectedDate: Date,
  ) async {
    await send(
      .responseGetStatistics(
        Result {
          try await self.pomodoroService.getStatistics(apiClient: self.apiClient, date: selectedDate)
        }
      )
    )
  }
}
