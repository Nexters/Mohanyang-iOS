//
//  PomodoroView.swift
//  PomodoroFeature
//
//  Created by devMinseok on 12/30/24.
//  Copyright © 2024 PomoNyang. All rights reserved.
//

import SwiftUI

import DesignSystem

import ComposableArchitecture

public struct PomodoroView: View {
  @Bindable var store: StoreOf<PomodoroCore>
  
  public init(store: StoreOf<PomodoroCore>) {
    self.store = store
  }
  
  public var body: some View {
    ZStack {
      if let store = store.scope(state: \.restPomodoro, action: \.restPomodoro) {
        RestPomodoroView(store: store)
          .transition(.opacity.animation(.easeInOut))
          .zIndex(2)
      } else if let store = store.scope(state: \.restWaiting, action: \.restWaiting) {
        RestWaitingView(store: store)
          .transition(.opacity.animation(.easeInOut))
          .zIndex(1)
      } else {
        FocusPomodoroView(
          store: store.scope(state: \.focusPomodoro, action: \.focusPomodoro)
        )
        .transition(.opacity.animation(.easeInOut))
        .zIndex(0)
      }
    }
  }
}
