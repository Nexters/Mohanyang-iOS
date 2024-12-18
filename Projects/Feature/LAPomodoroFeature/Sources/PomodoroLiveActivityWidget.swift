//
//  PomodoroLiveActivityWidget.swift
//  LAPomodoroFeature
//
//  Created by devMinseok on 11/24/24.
//  Copyright © 2024 PomoNyang. All rights reserved.
//

import SwiftUI
import WidgetKit

import PomodoroServiceInterface
import DesignSystem

import ComposableArchitecture

public struct PomodoroLiveActivityWidget: Widget {
  public init() {}
  
  public var body: some WidgetConfiguration {
    ActivityConfiguration(for: PomodoroActivityAttributes.self) { context in
      TimerLockScreenView(context: context)
    } dynamicIsland: { context in
      TimerDynamicIsland(context: context).body
    }
  }
}
