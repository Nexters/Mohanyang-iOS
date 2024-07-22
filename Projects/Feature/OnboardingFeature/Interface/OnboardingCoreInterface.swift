//
//  OnboardingCoreInterface.swift
//  OnboardingFeatureInterface
//
//  Created by devMinseok on 7/22/24.
//  Copyright © 2024 PomoNyang. All rights reserved.
//

import Foundation

import ComposableArchitecture

@Reducer
public struct OnboardingCore {
  private let reducer: Reduce<State, Action>
  
  public init(reducer: Reduce<State, Action>) {
    self.reducer = reducer
  }
  
  @ObservableState
  public struct State: Equatable {
    public init() {}
  }
  
  public enum Action {
    case onAppear
  }
  
  public var body: some ReducerOf<Self> {
    reducer
  }
}
