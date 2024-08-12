//
//  HomeCore.swift
//  HomeFeature
//
//  Created by devMinseok on 7/22/24.
//  Copyright © 2024 PomoNyang. All rights reserved.
//

import UserNotifications

import PushService
import UserNotificationClientInterface

import ComposableArchitecture

@Reducer
public struct HomeCore {
  @ObservableState
  public struct State: Equatable {
    
    var homeCatTooltip: HomeCatDialogueTooltip?
    @Presents var categorySelect: CategorySelectCore.State?
    
    public init() {}
  }
  
  public enum Action {
    case onAppear
    case setHomeCatTooltip(HomeCatDialogueTooltip?)
    case categoryButtonTapped
    case mypageButtonTappd
    case playButtonTapped
    
    case categorySelect(PresentationAction<CategorySelectCore.Action>)
  }
  
  @Dependency(UserNotificationClient.self) var userNotificationClient
  
  public init() {}
  
  public var body: some ReducerOf<Self> {
    Reduce(self.core)
      .ifLet(\.$categorySelect, action: \.categorySelect) {
        CategorySelectCore()
      }
  }
  
  private func core(_ state: inout State, _ action: Action) -> EffectOf<Self> {
    switch action {
    case .onAppear:
      state.homeCatTooltip = .init(title: "오랜만이다냥")
      return .none
      
    case let .setHomeCatTooltip(tooltip):
//      state.homeCatTooltip = tooltip
      return .none
      
    case .categoryButtonTapped:
      return .none
      
    case .mypageButtonTappd:
      return .none
      
    case .playButtonTapped:
      state.categorySelect = .init()
      return .none
      
//    case .categorySelect(.presented(.dismissButtonTapped)):
//      state.categorySelect = nil
//      return .none
      
    case .categorySelect:
      return .none
//    case .localPushButtonTapped:
//      let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 10, repeats: false)
//      return .run { send in
//        do {
//          try await scheduleNotification(
//            userNotificationClient: userNotificationClient,
//            contentType: .test,
//            trigger: trigger
//          )
//        } catch {
//          print(error)
//        }
//      }
    }
  }
}
