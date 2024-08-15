//
//  TimeSelectCore.swift
//  HomeFeature
//
//  Created by devMinseok on 8/13/24.
//  Copyright © 2024 PomoNyang. All rights reserved.
//

import Foundation

import ComposableArchitecture

@Reducer
public struct TimeSelectCore {
  @ObservableState
  public struct State: Equatable {
    var timeList: [TimeItem] = []
    var selectedTime: TimeItem?
    
    public init() {}
  }
  
  public enum Action {
    case onAppear
    case pickerSelection(TimeItem?)
  }
  
//  <#@Dependency() var#>
  
  public init() {}
  
  public var body: some ReducerOf<Self> {
    Reduce(self.core)
  }
  
  private func core(state: inout State, action: Action) -> EffectOf<Self> {
    switch action {
    case .onAppear:
      state.timeList = generateFocusTimeByMinute().map { .init(title: "\($0):00", data: $0) }
      state.selectedTime = state.timeList.last
      return .none
      
    case let .pickerSelection(selection):
      state.selectedTime = selection
      print(selection?.title)
      return .none
    }
  }
  
  /// 집중시간 리스트 생성 (분)
  private func generateFocusTimeByMinute() -> [Int] {
    var result: [Int] = []
    for i in stride(from: 10, through: 60, by: 5) {
      result.append(i)
    }
    return result.reversed()
  }
  
  /// 휴식시간 리스트 생성 (분)
  private func generateRelaxTimeByMinute() -> [Int] {
    var result: [Int] = []
    for i in stride(from: 5, through: 30, by: 5) {
      result.append(i)
    }
    return result.reversed()
  }
}
