//
//  ContentView.swift
//  PushService
//
//  Created by devMinseok on 7/24/24.
//

import SwiftUI

import UserNotificationClientInterface
import PushService

import Dependencies

struct ContentView: View {
  @State var selectedInterval: Int = 0
  @Dependency(\.userNotificationClient) var userNotificationClient
  
  var body: some View {
    VStack {
      Picker("test", selection: $selectedInterval) {
        ForEach(0..<100, id: \.self) { interval in
          Text("\(interval)초")
        }
      }
      .pickerStyle(WheelPickerStyle())
      
      Button {
        sendLocalPushNotification()
      } label: {
        Text("로컬 푸시 발송")
      }
    }
    .padding()
    .onAppear {
      notiAuthHandler()
      requestNotiAuth()
    }
  }
  
  func notiAuthHandler() {
    let userNotificationEventStream = self.userNotificationClient.delegate()
    Task {
      for await event in userNotificationEventStream {
        switch event {
        case let .didReceiveResponse(_, completionHandler):
          completionHandler()
        case .openSettingsForNotification(_):
          break
        case let .willPresentNotification(_, completionHandler):
          completionHandler([.banner, .list, .sound])
        }
      }
    }
  }
  
  func requestNotiAuth() {
    Task {
      try await userNotificationClient.requestAuthorization([.alert, .badge, .sound])
    }
  }
  
  func sendLocalPushNotification() {
    let trigger = UNTimeIntervalNotificationTrigger(
      timeInterval: TimeInterval(selectedInterval),
      repeats: false
    )
    Task {
      try await scheduleNotification(
        userNotificationClient: self.userNotificationClient,
        contentType: .test,
        trigger: trigger
      )
    }
  }
}

#Preview {
  ContentView()
}
