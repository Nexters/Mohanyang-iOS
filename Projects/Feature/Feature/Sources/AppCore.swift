//
//  AppCore.swift
//  Feature
//
//  Created by devMinseok on 7/22/24.
//  Copyright 2024 PomoNyang. All rights reserved.
//

import SwiftUI

import SplashFeature
import HomeFeature
import OnboardingFeature
import ErrorFeature
import MyPageFeature
import PushService
import AppService
import UserDefaultsClientInterface
import UserNotificationClientInterface
import CatServiceInterface
import UserServiceInterface
import PomodoroServiceInterface
import DatabaseClientInterface
import StreamListenerInterface
import BackgroundTaskClientInterface
import LiveActivityClientInterface

import ComposableArchitecture

import BackgroundTasks

@Reducer
public struct AppCore {
  @ObservableState
  public struct State: Equatable {
    public var appDelegate: AppDelegateCore.State = .init()
    var splash: SplashCore.State?
    var home: HomeCore.State?
    var onboarding: OnboardingCore.State?
    @Presents var networkError: NetworkErrorCore.State?
    @Presents var requestError: RequestErrorCore.State?
    
    var isLoading: Bool = false
    
    public init() {}
  }
  
  public enum Action: BindableAction {
    case binding(BindingAction<State>)
    case onLoad
    case appDelegate(AppDelegateCore.Action)
    case didChangeScenePhase(ScenePhase)
    case splash(SplashCore.Action)
    case home(HomeCore.Action)
    case onboarding(OnboardingCore.Action)
    case networkError(PresentationAction<NetworkErrorCore.Action>)
    case requestError(PresentationAction<RequestErrorCore.Action>)
    case serverState(ServerState)
  }
  
  @Dependency(UserDefaultsClient.self) var userDefaultsClient
  @Dependency(UserNotificationClient.self) var userNotificationClient
  @Dependency(UserService.self) var userService
  @Dependency(DatabaseClient.self) var databaseClient
  @Dependency(StreamListener.self) var streamListener
  @Dependency(BackgroundTaskClient.self) var backgroundTaskClient
  @Dependency(LiveActivityClient.self) var liveActivityClient
  
  public init() {}
  
  public var body: some ReducerOf<Self> {
    BindingReducer()
    Scope(state: \.appDelegate, action: \.appDelegate) {
      AppDelegateCore()
    }
    Reduce(self.core)
      .ifLet(\.splash, action: \.splash) {
        SplashCore()
      }
      .ifLet(\.home, action: \.home) {
        HomeCore()
      }
      .ifLet(\.onboarding, action: \.onboarding) {
        OnboardingCore()
      }
      .ifLet(\.$networkError, action: \.networkError) {
        NetworkErrorCore()
      }
      .ifLet(\.$requestError, action: \.requestError) {
        RequestErrorCore()
      }
  }
  
  private func core(_ state: inout State, _ action: Action) -> EffectOf<Self> {
    switch action {
    case .binding:
      return .none
      
    case .onLoad:
      state.splash = SplashCore.State()
      return .run { send in
        let serverStateStream: AsyncStream<ServerState> = streamListener.protocolAdapter.receive(ServerState.self)
        for await serverState in serverStateStream {
          await send(.serverState(serverState))
        }
      }
      
    case .appDelegate:
      return .none
      
    case .didChangeScenePhase(.background):
      return .run { send in
        let pomodoroActivity = liveActivityClient.protocolAdapter.getActivities(type: PomodoroActivityAttributes.self).first
        let pendingBGTaskRequest = await backgroundTaskClient.pendingTaskRequests().first
        
        if let pomodoroActivity {
          if let pendingBGTaskRequest {
            if pendingBGTaskRequest.earliestBeginDate != pomodoroActivity.content.state.goalDatetime {
              backgroundTaskClient.cancel(identifier: pendingBGTaskRequest.identifier)
              await pomodoroActivity.update(pomodoroActivity.content)
              try submitUpdateLiveActivityBGTask(earliestBeginDate: pomodoroActivity.content.state.goalDatetime)
            }
          } else {
            try submitUpdateLiveActivityBGTask(earliestBeginDate: pomodoroActivity.content.state.goalDatetime)
          }
        } else {
          if let pendingBGTaskRequest {
            backgroundTaskClient.cancel(identifier: pendingBGTaskRequest.identifier)
          }
        }
      }
      
    case .didChangeScenePhase:
      return .none
      
    case .splash(.moveToHome):
      state.splash = nil
      state.home = HomeCore.State()
      return .none
      
    case .splash(.moveToOnboarding):
      state.splash = nil
      state.onboarding = OnboardingCore.State()
      return .none
      
    case .splash:
      return .none
      
    case .home:
      return .none
      
    case .onboarding(.selectCat(.presented(.namingCat(.presented(.moveToHome))))):
      state.onboarding = nil
      state.home = HomeCore.State()
      return .none
      
    case .onboarding:
      return .none
      
    case .networkError:
      return .none
      
    case .requestError(.presented(.moveToHome)):
      if state.onboarding != nil {
        state.onboarding = OnboardingCore.State()
      } else if state.home != nil {
        state.home = HomeCore.State()
      }
      return .none
      
    case .requestError:
      return .none
      
    case .serverState(let serverState):
      switch serverState {
      case .requestStarted:
        state.isLoading = true
      case .requestCompleted:
        state.isLoading = false
      case .errorOccured:
        state.isLoading = false
        state.requestError = RequestErrorCore.State()
      case .networkDisabled:
        state.isLoading = false
        state.networkError = NetworkErrorCore.State()
      }
      return .none
    }
  }
  
  func submitUpdateLiveActivityBGTask(earliestBeginDate: Date) throws {
    let request = BGProcessingTaskRequest(identifier: "com.pomonyang.mohanyang.update_LiveActivity")
    request.requiresExternalPower = false
    request.requiresNetworkConnectivity = false
    request.earliestBeginDate = earliestBeginDate
    try backgroundTaskClient.submit(taskRequest: request)
  }
}
