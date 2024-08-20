//
//  TimerCore.swift
//  PomodoroFeature
//
//  Created by devMinseok on 8/19/24.
//  Copyright © 2024 PomoNyang. All rights reserved.
//

import ComposableArchitecture

@Reducer
public struct TimerCore {
  @ObservableState
  public struct State: Equatable {
    var interval: Duration?
    var mode: Mode
    
    public init(
      interval: Duration? = nil,
      mode: Mode
    ) {
#if DEV
      self.interval = .milliseconds(interval?.components.seconds ?? 0)
#else
      self.interval = interval
#endif
      self.mode = mode
    }
  }
  
  public enum Action {
    case start
    case stop
    case tick
  }
  
  public enum Mode {
    case continuous
    case suspending
  }
  
  @Dependency(\.continuousClock) var continuousClock
  @Dependency(\.suspendingClock) var suspendingClock
  
  public init() {}
  
  public var body: some ReducerOf<Self> {
    Reduce(self.core)
  }
  
  private func core(state: inout State, action: Action) -> EffectOf<Self> {
    enum CancelID { case clock }
    
    switch action {
    case .start:
      return .run { [
        interval = state.interval,
        mode = state.mode
      ] send in
        guard let interval else { return }
        
        await withTaskCancellation(id: CancelID.clock, cancelInFlight: true) {
          switch mode {
          case .continuous:
            for await _ in self.continuousClock.timer(interval: interval) {
              await send(.tick)
            }
          case .suspending:
            for await _ in self.suspendingClock.timer(interval: interval) {
              await send(.tick)
            }
          }
        }
      }
      
    case .stop:
      return .cancel(id: CancelID.clock)
      
    case .tick:
      return .none
    }
  }
}
