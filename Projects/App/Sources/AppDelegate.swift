//
//  AppDelegate.swift
//  Mohanyang
//
//  Created by devMinseok on 7/23/24.
//  Copyright © 2024 PomoNyang. All rights reserved.
//

import SwiftUI
import UserNotifications

import Feature
import DesignSystem

import ComposableArchitecture

final class AppDelegate: UIResponder, UIApplicationDelegate {
  let store = Store(
    initialState: AppCore.State()
  ) {
    AppCore()
  }
  
  func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    self.store.send(.appDelegate(.didFinishLaunching))
    return true
  }
  
  func application(
    _ application: UIApplication,
    didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data
  ) {
    self.store.send(.appDelegate(.didRegisterForRemoteNotifications(.success(deviceToken))))
  }
  
  func application(
    _ application: UIApplication,
    didFailToRegisterForRemoteNotificationsWithError error: Error
  ) {
    self.store.send(.appDelegate(.didRegisterForRemoteNotifications(.failure(error))))
  }
}

@main
struct MohanyangApp: App {
  @UIApplicationDelegateAdaptor(AppDelegate.self) private var appDelegate
  @Environment(\.scenePhase) private var scenePhase
  
  init() {
    DesignSystemFontFamily.registerAllCustomFonts()
  }
  
  var body: some Scene {
    WindowGroup {
      AppView(store: self.appDelegate.store)
    }
    .onChange(of: self.scenePhase) { _, newValue in
      self.appDelegate.store.send(.didChangeScenePhase(newValue))
    }
  }
}
