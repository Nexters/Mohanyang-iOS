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
  @Bindable var store: StoreOf<PomodoroLiveActivityWidgetCore>
  
  public init() {
    store = .init(
      initialState: PomodoroLiveActivityWidgetCore.State(),
      reducer: { PomodoroLiveActivityWidgetCore() }
    )
  }
  
  public var body: some WidgetConfiguration {
    ActivityConfiguration(for: PomodoroActivityAttributes.self) { context in
      TimerLockScreenView(
        store: .init(
          initialState: .init(contentState: context.state),
          reducer: { TimerLockScreenCore() })
      )
    } dynamicIsland: { context in
      DynamicIsland {
        DynamicIslandExpandedRegion(.leading) {
          Text("Leading")
        }
        DynamicIslandExpandedRegion(.trailing) {
          Text("Trailing")
        }
        DynamicIslandExpandedRegion(.center) {
          Text("Center")
        }
        DynamicIslandExpandedRegion(.bottom) {
          Text("Bottom")
        }
      } compactLeading: {
        Text("Leading")
      } compactTrailing: {
        Text("Trailing")
      } minimal: {
        Text("Minimal")
      }
      .keylineTint(Alias.Color.Background.accent2)
    }
  }
}
