//
//  MyCatCore.swift
//  MyPageFeature
//
//  Created by 김지현 on 8/19/24.
//  Copyright © 2024 PomoNyang. All rights reserved.
//

import CatFeature
import CatServiceInterface
import DesignSystem
import UserServiceInterface
import DatabaseClientInterface

import ComposableArchitecture
import RiveRuntime

@Reducer
public struct MyCatCore {
  @ObservableState
  public struct State: Equatable {
    var cat: SomeCat?
    var tooltip: MyCatTooltip? = .init()
    var catRiv: RiveViewModel = Rive.catSelectRiv(stateMachineName: "State Machine_selectCat")
    @Presents var selectCat: SelectCatCore.State?
    @Presents var namingCat: NamingCatCore.State?
    
    public init() {}
  }
  
  public enum Action: BindableAction {
    case binding(BindingAction<State>)
    case onAppear
    case triggerCatAnimation
    case setTooltip(MyCatTooltip?)
    case changeCatButtonTapped
    case changeCatNameButtonTapped
    case selectCat(PresentationAction<SelectCatCore.Action>)
    case namingCat(PresentationAction<NamingCatCore.Action>)
  }
  
  @Dependency(UserService.self) var userService
  @Dependency(DatabaseClient.self) var databaseClient
  
  public init() {}
  
  public var body: some ReducerOf<Self> {
    BindingReducer()
    Reduce(self.core)
      .ifLet(\.$selectCat, action: \.selectCat) {
        SelectCatCore()
      }
      .ifLet(\.$namingCat, action: \.namingCat) {
        NamingCatCore()
      }
  }
  
  private func core(state: inout State, action: Action) -> EffectOf<Self> {
    switch action {
    case .binding:
      return .none
      
    case .onAppear:
      return .run { send in
        if let myCat = try await self.userService.getUserInfo(databaseClient: self.databaseClient)?.cat {
          await send(.set(\.cat, SomeCat(baseInfo: myCat)))
        }
        await send(.triggerCatAnimation)
      }
      
    case .triggerCatAnimation:
      guard let cat = state.cat else { return .none }
      state.catRiv.stop()
      state.catRiv.triggerInput(cat.rivTriggerName)
      return .none
      
    case .setTooltip:
      return .none
      
    case .changeCatButtonTapped:
      state.selectCat = SelectCatCore.State(route: .myPage)
      return .none
      
    case .changeCatNameButtonTapped:
      state.namingCat = NamingCatCore.State(route: .myPage)
      return .none
      
    case let .selectCat(.presented(.saveChangedCat(cat))):
      state.cat = cat
      state.selectCat = nil
      return .none
      
    case .selectCat:
      return .none
      
    case let .namingCat(.presented(.saveChangedCat(cat))):
      state.cat = cat
      state.namingCat = nil
      return .none
      
    case .namingCat:
      return .none
    }
  }
}
