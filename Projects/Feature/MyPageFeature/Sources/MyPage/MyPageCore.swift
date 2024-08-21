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
import NetworkTrackingInterface
import DesignSystem
import UserNotificationClientInterface

import ComposableArchitecture

@Reducer
public struct MyPageCore {
  @ObservableState
  public struct State: Equatable {
    var cat: AnyCat? = nil
    var isTimerAlarmOn: Bool = false
    var isDisturbAlarmOn: Bool = false
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
    case sendFeedbackButtonTapped
    case _goToNotificationSettings
    case _responseUserInfo(UserDTO.Response.GetUserInfoResponseDTO)
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
      return .run { send in
        let data = try await userService.getUserInfo(apiClient: apiClient)
        await send(._responseUserInfo(data))
      }

    case .task:
      return .run { send in
        for await isConnected in networkTracking.updateNetworkConnected() {
          await send(._fetchNetworkConntection(isConnected))
        }
      }

    case .myCatDetailTapped:
      guard let cat = state.cat else { return .none }
      state.myCat = MyCatCore.State(cat: cat)
      return .none
      
    case let .timerAlarmToggleButtonTapped(isOn):
      return .run { send in
        if isOn {
          let settings = await userNotificationClient.getNotificationSettings()
          if settings.authorizationStatus == .authorized {
            await send(.set(\.isTimerAlarmOn, true))
          } else {
            await send(.set(\.isTimerAlarmOn, false))
            let notificationSettingDialog = DefaultDialog(
              title: "설정에서 알림을 켜주세요",
              subTitle: "모하냥 앱의 알림 표시를 허용하면 Push 알림을 받을 수 있어요. 지금 설정하시겠어요?",
              firstButton: .init(title: "다음에"),
              secondButton: .init(
                title: "설정으로 이동",
                action: { await send(._goToNotificationSettings) }
              )
            )
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
            let notificationSettingDialog = DefaultDialog(
              title: "설정에서 알림을 켜주세요",
              subTitle: "모하냥 앱의 알림 표시를 허용하면 Push 알림을 받을 수 있어요.\n지금 설정하시겠어요?",
              firstButton: .init(title: "다음에"),
              secondButton: .init(
                title: "설정으로 이동",
                action: { await send(._goToNotificationSettings) }
              )
            )
            await send(.set(\.dialog, notificationSettingDialog))
          }
        } else {
          await send(.set(\.isDisturbAlarmOn, false))
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
      
    case ._responseUserInfo(let data):
      state.cat = CatFactory.makeCat(
        type: CatType(rawValue: data.cat.type.camelCased()) ?? .cheese,
        no: data.cat.no,
        name: data.cat.name
      )
      return .none

    case ._fetchNetworkConntection(let isConntected):
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

    case .binding:
      return .none
    }
  }
}
