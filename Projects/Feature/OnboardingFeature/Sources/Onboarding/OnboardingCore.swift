//
//  OnboardingCore.swift
//  OnboardingFeature
//
//  Created by devMinseok on 7/22/24.
//  Copyright © 2024 PomoNyang. All rights reserved.
//

import Foundation
import OnboardingFeatureInterface
import ComposableArchitecture

@Reducer
public struct OnboardingCore {
  @ObservableState
  public struct State: Equatable {
    public init() { }
    var data = RandomAccessEquatableItems<OnboardingItem>(elements: OnboardingItemsData)
    var fakedData: RandomAccessEquatableItems<OnboardingItem> = .init(elements: [])
    var width: CGFloat = .zero
    var currentIdx: Int = 0
    var currentItemID: String = ""
  }

  public enum Action: BindableAction {
    case onApear
    case setIndex(Int)
    case calculateOffset(CGFloat, OnboardingItem)
    case binding(BindingAction<State>)
  }

  public init() { }

  private enum CancelID { case timer }
  @Dependency(\.continuousClock) var clock

  public var body: some ReducerOf<Self> {
    BindingReducer()
    Reduce(self.core)
  }

  private func core(_ state: inout State, _ action: Action) -> EffectOf<Self> {
    switch action {
    case .onApear:
      state.currentItemID = state.data.first!.id.uuidString
      state.fakedData.elements = state.data.elements
      guard var first = state.data.first,
            var last = state.data.last else { return .none }
      first.id = .init()
      last.id = .init()
      state.fakedData.elements.append(first)
      state.fakedData.elements.insert(last, at: 0)
      return .none

    case .setIndex(let idx):
      state.currentIdx = idx
      return .none

    case .calculateOffset(let minX, let item):
      let fakeIndex = state.fakedData.firstIndex(of: item) ?? 0
      state.currentIdx = state.data.firstIndex { item in
        item.id.uuidString == state.currentItemID
      } ?? 0
      let pageOffset = minX - state.width * CGFloat(fakeIndex)
      let pageProgress: CGFloat = pageOffset / state.width
      if  -pageProgress < 1.0 {
        if state.fakedData.elements.indices.contains(state.fakedData.count - 1) {
          state.currentItemID = state.fakedData[state.fakedData.count - 1].id.uuidString
        }
      }
      if -pageProgress > CGFloat(state.fakedData.count - 1) {
        if state.fakedData.elements.indices.contains(1) {
          state.currentItemID = state.fakedData[1].id.uuidString
        }
      }
      return .none

    default:
      return .none
    }
  }
}
