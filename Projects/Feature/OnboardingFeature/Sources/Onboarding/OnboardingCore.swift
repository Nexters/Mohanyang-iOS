//
//  OnboardingCore.swift
//  OnboardingFeature
//
//  Created by devMinseok on 7/22/24.
//  Copyright © 2024 PomoNyang. All rights reserved.
//

import Foundation

import CatFeature

import ComposableArchitecture

@Reducer
public struct OnboardingCore {
  @ObservableState
  public struct State: Equatable {
    public init() { }
    var data: [OnboardingItem] = OnboardingItemsData
    var fakedData: [OnboardingItem] = []
    var width: CGFloat = .zero
    var currentIdx: Int = 0
    var currentItemID: String = ""
    @Presents var selectCat: SelectCatCore.State?
  }

  public enum Action: BindableAction {
    case onApear
    case calculateOffset(CGFloat, OnboardingItem)
    case dragStart
    case tapStartButton
    case _timerStart
    case _timerEnd
    case _timerTicked
    case _nextPage(Int)
    case _resetTofront
    case binding(BindingAction<State>)
    case selectCat(PresentationAction<SelectCatCore.Action>)
  }

  public init() { }

  @Dependency(\.continuousClock) var clock
  @Dependency(\.mainQueue) var mainQueue

  public var body: some ReducerOf<Self> {
    BindingReducer()
    Reduce(self.core)
      .ifLet(\.$selectCat, action: \.selectCat) {
        SelectCatCore()
      }
  }

  private func core(_ state: inout State, _ action: Action) -> EffectOf<Self> {
    enum CancelID { case timer, timerDebounce }

    switch action {
    case .onApear:
      state.currentItemID = state.data.first!.id.uuidString
      state.fakedData = state.data
      guard var first = state.data.first,
            var last = state.data.last else { return .none }
      first.id = .init()
      last.id = .init()
      state.fakedData.append(first)
      state.fakedData.insert(last, at: 0)
      return .run { send in
        await send(._timerStart)
      }

    case .calculateOffset(let minX, let item):
      let fakeIndex = state.fakedData.firstIndex(of: item) ?? 0
      state.currentIdx = state.data.firstIndex { item in
        item.id.uuidString == state.currentItemID
      } ?? 0
      let pageOffset = minX - state.width * CGFloat(fakeIndex)

      let pageProgress: CGFloat = pageOffset / state.width
      if  -pageProgress < 1.0 {
        if state.fakedData.indices.contains(state.fakedData.count - 1) {
          state.currentItemID = state.fakedData[state.fakedData.count - 1].id.uuidString
        }
      }
      if -pageProgress > CGFloat(state.fakedData.count - 1) {
        if state.fakedData.indices.contains(1) {
          state.currentItemID = state.fakedData[1].id.uuidString
        }
      }
      return .none

    case .dragStart:
      let timerEndAction: Effect<Action> = .run { send in await send(._timerEnd) }
      let timerStartAction: Effect<Action> = .run { send in await send(._timerStart) }
        .debounce(id: CancelID.timerDebounce, for: .seconds(2), scheduler: self.mainQueue)
      return .merge(
        timerEndAction,
        timerStartAction
      )

    case .tapStartButton:
      state.selectCat = SelectCatCore.State()
      return .run { send in await send(._timerEnd) }

    case ._timerStart:
      return .run { send in
        for await _ in self.clock.timer(interval: .seconds(3)) {
          await send(._timerTicked)
        }
      }
      .cancellable(id: CancelID.timer)

    case ._timerEnd:
      return .cancel(id: CancelID.timer)

    case ._timerTicked:
      let index = state.fakedData.firstIndex { item in
        item.id.uuidString == state.currentItemID
      } ?? 0
      return .run { [index = index] send in
        if index == 4 {
          await send(._resetTofront)
          await send(._nextPage(2), animation: .easeInOut(duration: 0.3))
        } else {
          await send(._nextPage(index + 1), animation: .easeInOut(duration: 0.3))
        }
      }

    case ._nextPage(let index):
      state.currentItemID = state.fakedData[index].id.uuidString
      return .none

    case ._resetTofront:
      state.currentItemID = state.fakedData[1].id.uuidString
      return .none

    case .binding:
      return .none

    case .selectCat:
      return .none
    }
  }
}
