//
//  DEP+XCFramework.swift
//  DependencyPlugin
//
//  Created by MinseokKang on 2024/07/15.
//

import ProjectDescription

extension DEP {
  /// XCFramework for target
  public enum XCFramework {}
}

public extension DEP.XCFramework {
  static let RealmSwift: TargetDependency = .xcframework(path: .relativeToRoot("XCFramework/Carthage/Build/RealmSwift.xcframework"))
  static let Realm: TargetDependency = .xcframework(path: .relativeToRoot("XCFramework/Carthage/Build/Realm.xcframework"))
  
  static let FirebaseAnalytics: TargetDependency = .xcframework(path: .relativeToRoot("XCFramework/Carthage/Build/FirebaseAnalytics.xcframework"))
  static let FirebaseCrashlytics: TargetDependency = .xcframework(path: .relativeToRoot("XCFramework/Carthage/Build/FirebaseCrashlytics.xcframework"))
  static let FirebaseInAppMessaging: TargetDependency = .xcframework(path: .relativeToRoot("XCFramework/Carthage/Build/FirebaseInAppMessaging.xcframework"))
  static let FirebaseMessaging: TargetDependency = .xcframework(path: .relativeToRoot("XCFramework/Carthage/Build/FirebaseMessaging.xcframework"))
  static let FirebaseCore: TargetDependency = .xcframework(path: .relativeToRoot("XCFramework/Carthage/Build/FirebaseCore.xcframework"))
  static let FirebaseInstallations: TargetDependency = .xcframework(path: .relativeToRoot("XCFramework/Carthage/Build/FirebaseInstallations.xcframework"))
  static let FirebaseCoreInternal: TargetDependency = .xcframework(path: .relativeToRoot("XCFramework/Carthage/Build/FirebaseCoreInternal.xcframework"))
  static let GoogleAppMeasurement: TargetDependency = .xcframework(path: .relativeToRoot("XCFramework/Carthage/Build/GoogleAppMeasurement.xcframework"))
  static let GoogleDataTransport: TargetDependency = .xcframework(path: .relativeToRoot("XCFramework/Carthage/Build/GoogleDataTransport.xcframework"))
  static let GoogleUtilities: TargetDependency = .xcframework(path: .relativeToRoot("XCFramework/Carthage/Build/GoogleUtilities.xcframework"))
  static let nanopb: TargetDependency = .xcframework(path: .relativeToRoot("XCFramework/Carthage/Build/nanopb.xcframework"))
  static let FBLPromises: TargetDependency = .xcframework(path: .relativeToRoot("XCFramework/Carthage/Build/FBLPromises.xcframework"))
  static let FirebaseABTesting: TargetDependency = .xcframework(path: .relativeToRoot("XCFramework/Carthage/Build/FirebaseABTesting.xcframework"))
  static let FirebasePerformance: TargetDependency = .xcframework(path: .relativeToRoot("XCFramework/Carthage/Build/FirebasePerformance.xcframework"))
  static let FirebaseSessions: TargetDependency = .xcframework(path: .relativeToRoot("XCFramework/Carthage/Build/FirebaseSessions.xcframework"))
  static let FirebaseRemoteConfig: TargetDependency = .xcframework(path: .relativeToRoot("XCFramework/Carthage/Build/FirebaseRemoteConfig.xcframework"))
  static let FirebaseRemoteConfigInterop: TargetDependency = .xcframework(path: .relativeToRoot("XCFramework/Carthage/Build/FirebaseRemoteConfigInterop.xcframework"))
  static let Promises: TargetDependency = .xcframework(path: .relativeToRoot("XCFramework/Carthage/Build/Promises.xcframework"))
  static let FirebaseCoreExtension: TargetDependency = .xcframework(path: .relativeToRoot("XCFramework/Carthage/Build/FirebaseCoreExtension.xcframework"))
  static let FirebaseSharedSwift: TargetDependency = .xcframework(path: .relativeToRoot("XCFramework/Carthage/Build/FirebaseSharedSwift.xcframework"))
}
