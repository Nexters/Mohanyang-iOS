//
//  RequestErrorCore.swift
//  ErrorFeature
//
//  Created by 김지현 on 11/24/24.
//  Copyright © 2024 PomoNyang. All rights reserved.
//

import Foundation

import ComposableArchitecture

@Reducer
public struct RequestErrorCore {
  @ObservableState
  public struct State: Equatable {
    public init() { }
  }

  public enum Action {
    case moveToHome
    case moveToCustomerService
  }

  public init() { }

  @Dependency(\.openURL) var openURL

  public var body: some ReducerOf<Self> {
    Reduce(self.core)
  }

  private func core(_ state: inout State, _ action: Action) -> EffectOf<Self> {
    switch action {
    case .moveToHome:
      return .none
    case .moveToCustomerService:
      guard let kakaoChannelURL = URL(string: "http://pf.kakao.com/_FvuAn") else { return .none }
      return .run { _ in await self.openURL(kakaoChannelURL) }
    }
  }
}
