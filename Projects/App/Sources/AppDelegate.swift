//
//  AppDelegate.swift
//  kimcaddie
//
//  Created by MinseokKang on 2019/07/04.
//  Copyright © 2022 Kimcaddie. All rights reserved.
//

import SwiftUI
import UserNotifications

import AppFeature
import DesignSystem

import ThirdParty_TCA
import ThirdParty_Firebase
import ThirdParty_Kakao

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
struct KimcaddieOwnerApp: App {
  @UIApplicationDelegateAdaptor(AppDelegate.self) private var appDelegate
  @Environment(\.scenePhase) private var scenePhase
  
  init() {
    DesignSystemFontFamily.registerAllCustomFonts()
  }
  
  var body: some Scene {
    WindowGroup {
      AppView(store: self.appDelegate.store)
    }
    .onChange(of: self.scenePhase) { value in
      self.appDelegate.store.send(.didChangeScenePhase(value))
    }
  }
}
