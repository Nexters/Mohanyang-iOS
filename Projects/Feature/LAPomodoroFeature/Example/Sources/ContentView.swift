//
//  ContentView.swift
//  LAPomodoroFeature
//
//  Created by MinseokKang on 11/23/24.
//

import SwiftUI
import ActivityKit

import LiveActivityClientInterface
import PomodoroServiceInterface

import Dependencies

struct ContentView: View {
  @State var testActivity: Activity<PomodoroActivityAttributes>?
  @Dependency(LiveActivityClient.self) var liveActivityClient
  
  var body: some View {
    VStack {
      Button {
        startTestActivity()
      } label: {
        Text("Pomodoro LiveActivity start")
      }
      
      Button {
        updateTestActivity()
      } label: {
        Text("Pomodoro LiveActivity update")
      }
      
      Button {
        endTestActivity()
      } label: {
        Text("Pomodoro LiveActivity end")
      }
    }
    .padding()
  }
  
  func startTestActivity() {
    testActivity = try? liveActivityClient.protocolAdapter.startActivity(
      attributes: PomodoroActivityAttributes(),
      content: .init(
        state: PomodoroActivityAttributes.ContentState(
          category: .init(no: 0, baseCategoryCode: .basic, title: "테스트", position: 0, focusTime: "PT10M", restTime: "PT10M"),
          goalDatetime: Date().addingTimeInterval(100),
          isRest: false
        ),
        staleDate: nil
      ),
      pushType: nil
    )
  }
  
  func updateTestActivity() {
    guard let testActivity else { return }
    
    Task {
      await liveActivityClient.protocolAdapter.updateActivity(
        PomodoroActivityAttributes.self,
        id: testActivity.id,
        content: .init(
          state: PomodoroActivityAttributes.ContentState(
            category: .init(no: 0, baseCategoryCode: .basic, title: "테스트2", position: 0, focusTime: "PT20M", restTime: "PT20M"),
            goalDatetime: Date().addingTimeInterval(100),
            isRest: false
          ),
          staleDate: nil
        )
      )
    }
  }
  
  func endTestActivity() {
    guard let testActivity else { return }
    
    Task {
      await liveActivityClient.protocolAdapter.endActivity(
        PomodoroActivityAttributes.self,
        id: testActivity.id,
        content: nil,
        dismissalPolicy: .immediate
      )
    }
  }
}

#Preview {
  ContentView()
}
