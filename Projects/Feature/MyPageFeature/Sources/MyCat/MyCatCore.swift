//
//  MyCatCore.swift
//  MyPageFeature
//
//  Created by 김지현 on 8/19/24.
//  Copyright © 2024 PomoNyang. All rights reserved.
//

import CatFeature
import CatServiceInterface

import ComposableArchitecture

@Reducer
public struct MyCatCore {
  @ObservableState
  public struct State: Equatable {
    var cat: AnyCat
    var tooltip: MyCatTooltip? = .init()
    @Presents var selectCat: SelectCatCore.State?
    @Presents var namingCat: NamingCatCore.State?
  }
  
  public enum Action {
    case setTooltip(MyCatTooltip?)
    case changeCatButtonTapped
    case changeCatNameButtonTapped
    case selectCat(PresentationAction<SelectCatCore.Action>)
    case namingCat(PresentationAction<NamingCatCore.Action>)
  }
  
  // @Dependency

  public init() {}
  
  public var body: some ReducerOf<Self> {
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
    case .setTooltip:
      return .none

    case .changeCatButtonTapped:
      state.selectCat = SelectCatCore.State(
        selectedCat: state.cat,
        route: .myPage
      )
      return .none

    case .changeCatNameButtonTapped:
      state.namingCat = NamingCatCore.State(
        selectedCat: state.cat,
        route: .myPage
      )
      return .none

    case .selectCat(.presented(.saveChangedCat(let cat))):
      state.cat = cat
      state.selectCat = nil
      return .none

    case .selectCat:
      return .none

    case .namingCat(.presented(.saveChangedCatName(let name))):
      state.cat.name = name
      state.namingCat = nil
      return .none

    case .namingCat:
      return .none
    }
  }
}
