//
//  FocusPomodoroCore.swift
//  PomodoroFeature
//
//  Created by devMinseok on 8/18/24.
//  Copyright © 2024 PomoNyang. All rights reserved.
//

import Foundation
import SwiftUI
import DesignSystem

import UserDefaultsClientInterface
import DatabaseClientInterface
import APIClientInterface
import UserNotificationClientInterface
import LiveActivityClientInterface
import AudioClientInterface
import CatServiceInterface
import PomodoroServiceInterface
import UserServiceInterface
import PushService
import AppService

import DesignSystem

import ComposableArchitecture
import RiveRuntime

@Reducer
public struct FocusPomodoroCore {
  @ObservableState
  public struct State: Equatable {
    var selectedCategory: PomodoroCategory?
    var goalDatetime: Date?
    var focusTimeBySeconds: Int = 0
    var overTimeBySeconds: Int = 0
    var timer: TimerCore.State = .init(interval: .seconds(1), mode: .continuous)
    var selectedCat: SomeCat?
    var catRiv: RiveViewModel = Rive.catFocusRiv(stateMachineName: "State Machine_Focus")
    var pushTriggered: Bool = false
    @Presents var restWaiting: RestWaitingCore.State?
    
    public init() {}
    
    var dialogueTooltip: PomodoroDialogueTooltip? {
      PomodoroDialogueTooltip(
        title: overTimeBySeconds > 0 ? "이제 나랑 놀자냥!" : "잘 집중하고 있는 거냥?"
      )
    }
    var focusedTime: Int {
      guard let selectedCategory else { return 0 }
      return selectedCategory.focusTimeSeconds - focusTimeBySeconds
    }
  }
  
  public enum Action: BindableAction {
    case onAppear
    case didChangeScenePhase(ScenePhase)
    case binding(BindingAction<State>)
    case task
    
    case takeRestButtonTapped
    case endFocusButtonTapped
    case catTapped
    case setupFocusTime
    case catSetInput
    case _pushNotificationTrigger
    case setupLiveActivity
    
    case goToHome
    case saveHistory(focusTimeBySeconds: Int, restTimeBySeconds: Int)
    
    case timer(TimerCore.Action)
    case restWaiting(PresentationAction<RestWaitingCore.Action>)
  }
  
  @Dependency(PomodoroService.self) var pomodoroService
  @Dependency(UserDefaultsClient.self) var userDefaultsClient
  @Dependency(DatabaseClient.self) var databaseClient
  @Dependency(APIClient.self) var apiClient
  @Dependency(UserService.self) var userService
  @Dependency(UserNotificationClient.self) var userNotificationClient
  @Dependency(LiveActivityClient.self) var liveActivityClient
  @Dependency(AudioClient.self) var audioClient
  
  public init() {}
  
  public var body: some ReducerOf<Self> {
    BindingReducer()
    Scope(state: \.timer, action: \.timer) {
      TimerCore()
    }
    Reduce(self.core)
      .ifLet(\.$restWaiting, action: \.restWaiting) {
        RestWaitingCore()
      }
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
      
    case .didChangeScenePhase(.background):
      let isDisturbAlarmEnabled = getDisturbAlarm(userDefaultsClient: self.userDefaultsClient)
      return .run { send in
        if isDisturbAlarmEnabled,
           let myCatInfo = try await self.userService.getUserInfo(databaseClient: self.databaseClient)?.cat {
          let trigger = UNTimeIntervalNotificationTrigger(
            timeInterval: TimeInterval(10),
            repeats: false
          )
          try await scheduleNotification(
            userNotificationClient: self.userNotificationClient,
            contentType: .disturb(SomeCat(baseInfo: myCatInfo)),
            trigger: trigger
          )
        }
      }
      
    case .didChangeScenePhase(.active):
      return .merge(
        .run { send in
          let settings = await self.userNotificationClient.getNotificationSettings()
          if settings.authorizationStatus != .authorized {
            await setTimerAlarm(userDefaultsClient: self.userDefaultsClient, isEnabled: false)
            await setDisturbAlarm(userDefaultsClient: self.userDefaultsClient, isEnabled: false)
          }
        },
        .run { _ in
          await removePendingNotification(userNotificationClient: self.userNotificationClient, identifier: ["disturb"])
        }
      )
      
    case .didChangeScenePhase:
      return .none
      
    case .binding:
      return .none
      
    case .task:
      return .run { send in
        let selectedCategory = try await self.pomodoroService.getSelectedCategory(
          userDefaultsClient: self.userDefaultsClient,
          databaseClient: self.databaseClient
        )
        await send(.set(\.selectedCategory, selectedCategory))
        await send(.setupFocusTime)
        await send(.setupLiveActivity)
        await send(.timer(.start))
      }
      
    case .takeRestButtonTapped:
      state.restWaiting = RestWaitingCore.State(
        source: .focusPomodoro,
        focusedTimeBySeconds: state.focusedTime,
        overTimeBySeconds: state.overTimeBySeconds
      )
      return .none
      
    case .endFocusButtonTapped:
      return .run { [focusedTime = state.focusedTime] send in
        await send(.saveHistory(focusTimeBySeconds: focusedTime, restTimeBySeconds: 0))
        await send(.goToHome)
      }
      
    case .catTapped:
      guard let selectedCat = state.selectedCat else { return .none }
      state.catRiv.triggerInput(selectedCat.rivTriggerName)
      return .none
      
    case .setupFocusTime:
      guard let selectedCategory = state.selectedCategory else { return .none }
      state.goalDatetime = Date().addingTimeInterval(Double(selectedCategory.focusTimeSeconds))
      state.focusTimeBySeconds = selectedCategory.focusTimeSeconds
      return .none
      
    case .catSetInput:
      guard let selectedCat = state.selectedCat else { return .none }
      state.catRiv.reset()
      state.catRiv.setInput(selectedCat.rivInputName, value: true)
      return .none
      
    case ._pushNotificationTrigger:
      let isTimerAlarmOn = getTimerAlarm(userDefaultsClient: self.userDefaultsClient)
      guard isTimerAlarmOn,
            let selectedCat = state.selectedCat
      else { return .none }
      return .run { _ in
        let trigger = UNTimeIntervalNotificationTrigger(
          timeInterval: 0.1,
          repeats: false
        )
        try await scheduleNotification(
          userNotificationClient: self.userNotificationClient,
          contentType: .focusEnd(selectedCat),
          trigger: trigger
        )
      }
      
    case .setupLiveActivity:
      let isLiveActivityAllowed = getLiveActivityState(userDefaultsClient: self.userDefaultsClient)
      guard isLiveActivityAllowed,
            let category = state.selectedCategory,
            let goalDatetime = state.goalDatetime
      else { return .none }
      
      let activity = try? liveActivityClient.protocolAdapter.startActivity(
        attributes: PomodoroActivityAttributes(),
        content: .init(
          state: .init(category: category, goalDatetime: goalDatetime, isRest: false),
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
      
    case .goToHome:
      return .none
      
    case .saveHistory:
      return .none
      
    case .timer(.tick):
      guard let goalDatetime = state.goalDatetime else { return .none }
      
      let timeDifference = timeDifferenceInSeconds(from: Date.now, to: goalDatetime)
      
      if state.focusTimeBySeconds == 0 {
        if !state.pushTriggered {
          state.pushTriggered = true
          return .run { send in
            await send(._pushNotificationTrigger)
            try await self.audioClient.playSound(fileURL: Files.timerEndSoundMp3.url) // 개선
          }
        }
        if state.overTimeBySeconds == 3600 { // 60분 초과시 휴식 대기화면으로 이동
          return .run { [state] send in
            await send(.timer(.stop)) // task가 cancel을 해주지만 일단 action 중복을 방지하기 위해 명시적으로 stop
            let restWaitingState = RestWaitingCore.State(
              source: .overtimeFromFocusPomodoro,
              focusedTimeBySeconds: state.focusedTime,
              overTimeBySeconds: state.overTimeBySeconds
            )
            await send(.set(\.restWaiting, restWaitingState))
          }
        } else {
          state.overTimeBySeconds = timeDifference
        }
      } else {
        state.focusTimeBySeconds = timeDifference
      }
      return .none
      
    case .timer:
      return .none
      
    case .restWaiting(.presented(.restPomodoro(.presented(.goToFocus)))):
      state.restWaiting = nil
      return .none
      
    case .restWaiting:
      return .none
    }
  }
  
  func timeDifferenceInSeconds(from startDate: Date, to endDate: Date) -> Int {
    let difference = Int(endDate.timeIntervalSince(startDate))
    return difference
  }
}
