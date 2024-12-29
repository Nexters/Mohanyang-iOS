//
//  RestPomodoroCore.swift
//  PomodoroFeature
//
//  Created by devMinseok on 8/19/24.
//  Copyright © 2024 PomoNyang. All rights reserved.
//

import Foundation

import UserDefaultsClientInterface
import DatabaseClientInterface
import APIClientInterface
import LiveActivityClientInterface
import UserNotificationClientInterface
import CatServiceInterface
import UserServiceInterface
import PomodoroServiceInterface
import PushService
import AppService
import DesignSystem

import ComposableArchitecture
import RiveRuntime

@Reducer
public struct RestPomodoroCore {
  @ObservableState
  public struct State: Equatable {
    let focusedTimeBySeconds: Int
    var goalDatetime: Date?
    var selectedCategory: PomodoroCategory?
    var restTimeBySeconds: Int = 0
    var overTimeBySeconds: Int = 0
    var changeRestTimeByMinute: Int = 0
    var toast: DefaultToast?
    var selectedCat: SomeCat?
    var pushTriggered: Bool = false
    var catRiv: RiveViewModel = Rive.catRestRiv(stateMachineName: "State Machine_Home")
    var timer: TimerCore.State = .init(interval: .seconds(1), mode: .continuous)
    
    public init(focusedTimeBySeconds: Int) {
      self.focusedTimeBySeconds = focusedTimeBySeconds
    }
    
    var dialogueTooltip: PomodoroDialogueTooltip? {
      PomodoroDialogueTooltip(
        title: overTimeBySeconds > 0 ? "이제 다시 사냥놀이 하자냥!" : "쉬는 게 제일 좋다냥"
      )
    }
    var minus5MinuteButtonDisabled: Bool {
      guard let restTimeMinute = selectedCategory?.restTimeMinutes else { return false }
      return restTimeMinute <= 5
    }
    var plus5MinuteButtonDisabled: Bool {
      guard let restTimeMinute = selectedCategory?.restTimeMinutes else { return false }
      return restTimeMinute >= 30
    }
  }
  
  public enum Action: BindableAction {
    case onAppear
    case binding(BindingAction<State>)
    case task
    
    case focusAgainButtonTapped
    case endFocusButtonTapped
    case minus5MinuteButtonTapped
    case plus5MinuteButtonTapped
    case setupRestTime
    case catTapped
    case catSetInput
    case setupLiveActivity
    case setupPushNotification
    
    case goToHome
    case goToFocus
    case saveHistory(focusTimeBySeconds: Int, restTimeBySeconds: Int)
    
    case timer(TimerCore.Action)
  }
  
  @Dependency(PomodoroService.self) var pomodoroService
  @Dependency(UserDefaultsClient.self) var userDefaultsClient
  @Dependency(DatabaseClient.self) var databaseClient
  @Dependency(APIClient.self) var apiClient
  @Dependency(UserService.self) var userService
  @Dependency(UserNotificationClient.self) var userNotificationClient
  @Dependency(LiveActivityClient.self) var liveActivityClient
  
  public init() {}
  
  public var body: some ReducerOf<Self> {
    BindingReducer()
    Scope(state: \.timer, action: \.timer) {
      TimerCore()
    }
    Reduce(self.core)
  }
  
  private func core(state: inout State, action: Action) -> EffectOf<Self> {
    switch action {
    case .onAppear:
      return .run { send in
        if let myCat = try await self.userService.getUserInfo(databaseClient: self.databaseClient)?.cat {
          await send(.set(\.selectedCat, SomeCat(baseInfo: myCat)))
        }
        await send(.catSetInput)
      }

    case .binding:
      return .none
      
    case .task:
      return .run { send in
        let selectedCategory = try await self.pomodoroService.getSelectedCategory(
          userDefaultsClient: self.userDefaultsClient,
          databaseClient: self.databaseClient
        )
        await send(.set(\.selectedCategory, selectedCategory))
        await send(.setupRestTime)
        await send(.setupLiveActivity)
        await send(.setupPushNotification)
        await send(.timer(.start))
        await send(.timer(.tick))
      }
      
    case .focusAgainButtonTapped:
      return .run { [state] send in
        await send(.saveHistory(focusTimeBySeconds: state.focusedTimeBySeconds, restTimeBySeconds: state.restTimeBySeconds))
        try await applyChangeRestTime(state: state)
        await send(.goToFocus)
      }
      
    case .endFocusButtonTapped:
      return .run { [state] send in
        await send(.saveHistory(focusTimeBySeconds: state.focusedTimeBySeconds, restTimeBySeconds: state.restTimeBySeconds))
        try await applyChangeRestTime(state: state)
        await send(.goToHome)
      }
      
    case .minus5MinuteButtonTapped:
      guard !state.minus5MinuteButtonDisabled else {
        state.toast = .init(message: "5분은 휴식해야 다음에 집중할 수 있어요", image: DesignSystemAsset.Image._24Clock.swiftUIImage)
        return .none
      }
      if state.changeRestTimeByMinute == -5 {
        state.changeRestTimeByMinute = 0
      } else {
        state.changeRestTimeByMinute = -5
      }
      return .none
      
    case .plus5MinuteButtonTapped:
      guard !state.plus5MinuteButtonDisabled else {
        state.toast = .init(message: "최대 30분까지만 휴식할 수 있어요", image: DesignSystemAsset.Image._24Clock.swiftUIImage)
        return .none
      }
      if state.changeRestTimeByMinute == 5 {
        state.changeRestTimeByMinute = 0
      } else {
        state.changeRestTimeByMinute = 5
      }
      return .none
      
    case .setupRestTime:
      guard let selectedCategory = state.selectedCategory else { return .none }
      state.goalDatetime = Date().addingTimeInterval(Double(selectedCategory.restTimeSeconds))
      state.restTimeBySeconds = selectedCategory.restTimeSeconds
      return .none
      
    case .catTapped:
      guard let selectedCat = state.selectedCat else { return .none }
      state.catRiv.triggerInput(selectedCat.rivTriggerName)
      return .none
      
    case .catSetInput:
      guard let selectedCat = state.selectedCat else { return .none }
      state.catRiv.reset()
      state.catRiv.setInput(selectedCat.rivInputName, value: true)
      return .none
      
    case .setupLiveActivity:
      let isLiveActivityAllowed = getLiveActivityState(userDefaultsClient: self.userDefaultsClient)
      guard isLiveActivityAllowed,
            let category = state.selectedCategory,
            let goalDatetime = state.goalDatetime
      else { return .none }
      
      let activity = try? liveActivityClient.protocolAdapter.startActivity(
        attributes: PomodoroActivityAttributes(),
        content: .init(
          state: .init(category: category, goalDatetime: goalDatetime, isRest: true),
          staleDate: nil
        ),
        pushType: nil
      )
      return .run { _ in
        do {
          try await Task.never()
        } catch {
          if let currentActivityID = activity?.id {
            await liveActivityClient.protocolAdapter.endActivity(
              PomodoroActivityAttributes.self,
              id: currentActivityID,
              content: nil,
              dismissalPolicy: .immediate
            )
          }
        }
      }
      
    case .setupPushNotification:
      let isTimerAlarmOn = getTimerAlarm(userDefaultsClient: self.userDefaultsClient)
      guard isTimerAlarmOn,
            let selectedCat = state.selectedCat,
            let timeInterval = state.goalDatetime?.timeIntervalSinceNow
      else { return .none }
      return .run { _ in
        let trigger = UNTimeIntervalNotificationTrigger(
          timeInterval: timeInterval,
          repeats: false
        )
        try await scheduleNotification(
          userNotificationClient: self.userNotificationClient,
          contentType: .restEnd(selectedCat),
          trigger: trigger
        )
        
        do {
          try await Task.never()
        } catch {
          await removePendingNotification(
            userNotificationClient: self.userNotificationClient,
            identifier: ["restEnd"]
          )
        }
      }
      
    case .goToHome:
      return .none
      
    case .goToFocus:
      return .none
      
    case .saveHistory:
      return .none
      
    case .timer(.tick):
      guard let goalDatetime = state.goalDatetime else { return .none }
      let timeDifference = timeDifferenceInSeconds(from: Date.now, to: goalDatetime)
      
      if state.restTimeBySeconds <= 0 {
        if state.overTimeBySeconds >= 1800 { // 30분 초과시 휴식 대기화면으로 이동
          return .run { [state] send in
            await send(.timer(.stop)) // task가 cancel을 해주지만 일단 action 중복을 방지하기 위해 명시적으로 stop
            await send(.saveHistory(focusTimeBySeconds: state.focusedTimeBySeconds, restTimeBySeconds: state.restTimeBySeconds))
            await send(.goToHome)
          }
        } else {
          state.overTimeBySeconds = -(timeDifference)
        }
      } else {
        state.restTimeBySeconds = timeDifference
      }
      return .none
      
    case .timer:
      return .none
    }
  }
  
  func applyChangeRestTime(state: State) async throws -> Void {
    guard let selectedCategory = state.selectedCategory,
          state.changeRestTimeByMinute != 0
    else { return }
    
    let changedTimeMinute = selectedCategory.restTimeMinutes + state.changeRestTimeByMinute
    let iso8601Duration = DateComponents(minute: changedTimeMinute).to8601DurationString()
    let request = EditCategoryRequest(focusTime: nil, restTime: iso8601Duration)
    
    try await self.pomodoroService.changeCategoryTime(
      apiClient: self.apiClient,
      categoryID: selectedCategory.id,
      request: request
    )
    try await self.pomodoroService.syncCategoryList(
      apiClient: self.apiClient,
      databaseClient: self.databaseClient
    )
  }
}
