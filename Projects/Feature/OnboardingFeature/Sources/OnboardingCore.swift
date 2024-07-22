//
//  OnboardingCore.swift
//  OnboardingFeature
//
//  Created by devMinseok on 7/22/24.
//  Copyright © 2024 PomoNyang. All rights reserved.
//

import OnboardingFeatureInterface

import ComposableArchitecture

extension OnboardingCore {
  public init() {
    let reducer = Reduce<State, Action> { state, action  in
      switch action {
      case .onAppear:
        return .none
      }
    }
    self.init(reducer: reducer)
  }
}
