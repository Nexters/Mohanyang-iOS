//
//  MyPageCore.swift
//  MyPageFeature
//
//  Created by 김지현 on 8/19/24.
//  Copyright © 2024 PomoNyang. All rights reserved.
//

import UIKit.UIApplication

import CatFeature
import AppService
import UserServiceInterface
import CatServiceInterface
import APIClientInterface
import UserDefaultsClientInterface
import DatabaseClientInterface
import NetworkTrackingInterface
import UserNotificationClientInterface
import LiveActivityClientInterface
import DesignSystem

import ComposableArchitecture

@Reducer
public struct MyPageCore {
  @ObservableState
  public struct State: Equatable {
    var cat: SomeCat?
    var isTimerAlarmOn: Bool = false
    var isDisturbAlarmOn: Bool = false
    var isLiveActivityOn: Bool = false
    var isNetworkConnected: Bool = false
    var dialog: DefaultDialog?
    @Presents var myCat: MyCatCore.State?
    
    public init() {}
  }
  
  public enum Action: BindableAction {
    case onAppear
    case task
    case myCatDetailTapped
    case timerAlarmToggleButtonTapped(Bool)
    case disturbAlarmToggleButtonTapped(Bool)
    case liveActivityToggleButtonTapped(Bool)
    case sendFeedbackButtonTapped
    case _goToNotificationSettings
    case _fetchNetworkConntection(Bool)
    case myCat(PresentationAction<MyCatCore.Action>)
    case binding(BindingAction<State>)
  }
  
  @Dependency(APIClient.self) var apiClient
  @Dependency(UserService.self) var userService
  @Dependency(UserDefaultsClient.self) var userDefaultsClient
  @Dependency(NetworkTracking.self) var networkTracking
  @Dependency(UserNotificationClient.self) var userNotificationClient
  @Dependency(\.openURL) var openURL
  @Dependency(DatabaseClient.self) var databaseClient
  @Dependency(LiveActivityClient.self) var liveActivityClient
  
  public init() {}
  
  public var body: some ReducerOf<Self> {
    BindingReducer()
    Reduce(self.core)
      .ifLet(\.$myCat, action: \.myCat) {
        MyCatCore()
      }
  }
  
  private func core(state: inout State, action: Action) -> EffectOf<Self> {
    switch action {
    case .onAppear:
      state.isTimerAlarmOn = getTimerAlarm(userDefaultsClient: self.userDefaultsClient)
      state.isDisturbAlarmOn = getDisturbAlarm(userDefaultsClient: self.userDefaultsClient)
      state.isLiveActivityOn =  getLiveActivityState(userDefaultsClient: self.userDefaultsClient)
      return .run { send in
        if let myCat = try await userService.getUserInfo(databaseClient: self.databaseClient)?.cat {
          await send(.set(\.cat, SomeCat(baseInfo: myCat)))
        }
      }
      
    case .task:
      return .run { send in
        for await isConnected in networkTracking.updateNetworkConnected() {
          await send(._fetchNetworkConntection(isConnected))
        }
      }
      
    case .myCatDetailTapped:
      state.myCat = MyCatCore.State()
      return .none
      
    case let .timerAlarmToggleButtonTapped(isOn):
      return .run { send in
        if isOn {
          let settings = await userNotificationClient.getNotificationSettings()
          if settings.authorizationStatus == .authorized {
            await send(.set(\.isTimerAlarmOn, true))
          } else {
            await send(.set(\.isTimerAlarmOn, false))
            let notificationSettingDialog = turnOnNotificationSettingDialog {
              await send(._goToNotificationSettings)
            }
            await send(.set(\.dialog, notificationSettingDialog))
          }
        } else {
          await send(.set(\.isTimerAlarmOn, false))
        }
      }
      
    case let .disturbAlarmToggleButtonTapped(isOn):
      return .run { send in
        if isOn {
          let settings = await userNotificationClient.getNotificationSettings()
          if settings.authorizationStatus == .authorized {
            await send(.set(\.isDisturbAlarmOn, true))
          } else {
            await send(.set(\.isDisturbAlarmOn, false))
            let notificationSettingDialog = turnOnNotificationSettingDialog {
              await send(._goToNotificationSettings)
            }
            await send(.set(\.dialog, notificationSettingDialog))
          }
        } else {
          await send(.set(\.isDisturbAlarmOn, false))
        }
      }
      
    case let .liveActivityToggleButtonTapped(isOn):
      return .run { send in
        if isOn {
          let isLiveActivityAllowed = liveActivityClient.protocolAdapter.isLiveActivityAllowed()
          if isLiveActivityAllowed {
            await send(.set(\.isLiveActivityOn, true))
          } else {
            await send(.set(\.isLiveActivityOn, false))
            let notificationSettingDialog = turnOnLiveActivitySettingDialog {
              await send(._goToNotificationSettings)
            }
            await send(.set(\.dialog, notificationSettingDialog))
          }
        } else {
          await send(.set(\.isLiveActivityOn, false))
        }
      }
      
    case .sendFeedbackButtonTapped:
      guard let feedbackURL = URL(string: "https://forms.gle/wEUPH9Tvxgua4hCZ9") else { return .none }
      return .run { _ in
        await self.openURL(feedbackURL)
      }
      
    case ._goToNotificationSettings:
      guard let notificationSettingsURL = URL(
        string: UIApplication.openNotificationSettingsURLString
      ) else {
        return .none
      }
      return .run { _ in
        await self.openURL(notificationSettingsURL)
      }
      
    case let ._fetchNetworkConntection(isConntected):
      state.isNetworkConnected = isConntected
      return .none
      
    case .myCat:
      return .none
      
    case .binding(\.isTimerAlarmOn):
      return .run { [isTimerAlarmOn = state.isTimerAlarmOn] _ in
        await setTimerAlarm(
          userDefaultsClient: self.userDefaultsClient,
          isEnabled: isTimerAlarmOn
        )
      }
      
    case .binding(\.isDisturbAlarmOn):
      return .run { [isDisturbAlarmOn = state.isDisturbAlarmOn] _ in
        await setDisturbAlarm(
          userDefaultsClient: self.userDefaultsClient,
          isEnabled: isDisturbAlarmOn
        )
      }
      
    case .binding(\.isLiveActivityOn):
      return .run { [isLiveActivityOn = state.isLiveActivityOn] _ in
        await setLiveActivityState(
          userDefaultsClient: self.userDefaultsClient,
          isEnabled: isLiveActivityOn
        )
      }
      
    case .binding:
      return .none
    }
  }
}

extension MyPageCore {
  private func turnOnNotificationSettingDialog(action: @escaping () async -> Void) -> DefaultDialog {
    return DefaultDialog(
      title: "설정에서 알림을 켜주세요",
      subTitle: "모하냥 앱의 알림 표시를 허용하면 Push 알림을 받을 수 있어요. 지금 설정하시겠어요?",
      firstButton: .init(title: "다음에"),
      secondButton: .init(
        title: "설정으로 이동",
        action: action
      ),
      showCloseButton: false
    )
  }
  
  private func turnOnLiveActivitySettingDialog(action: @escaping () async -> Void) -> DefaultDialog {
    return DefaultDialog(
      title: "설정에서 실시간 현황을 켜주세요",
      subTitle: "설정에서 모하냥 앱의 실시간 현황 보기를 허용하면 잠금화면에서도 뽀모도로를 볼 수 있어요. 지금 설정하시겠어요?",
      firstButton: .init(title: "다음에"),
      secondButton: .init(
        title: "설정으로 이동",
        action: action
      ),
      showCloseButton: false
    )
  }
}
