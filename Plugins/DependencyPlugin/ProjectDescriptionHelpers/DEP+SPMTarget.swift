//
//  DEP+SPMTarget.swift
//  DependencyPlugin
//
//  Created by MinseokKang on 2024/07/15.
//

import ProjectDescription

extension DEP {
  /// SwiftPackageManager for Target
  public enum SPMTarget {}
}

public extension DEP.SPMTarget {
  static let composableArchitecture: TargetDependency = .external(name: "ComposableArchitecture")
  static let dependencies: TargetDependency = .external(name: "Dependencies")
  static let riveRuntime: TargetDependency = .external(name: "RiveRuntime")
  static let lottie: TargetDependency = .external(name: "Lottie")
  static let datadogCore: TargetDependency = .external(name: "DatadogCore")
  static let datadogRUM: TargetDependency = .external(name: "DatadogRUM")

  // MARK: - Firebase
  static let FirebaseMessaging: TargetDependency = .external(name: "FirebaseMessaging")
  static let FirebaseCrashlytics: TargetDependency = .external(name: "FirebaseCrashlytics")
  static let FirebaseAnalytics: TargetDependency = .external(name: "FirebaseAnalytics")
  static let FirebasePerformance: TargetDependency = .external(name: "FirebasePerformance")

  // MARK: - Database
  static let Realm: TargetDependency = .external(name: "Realm")
  static let RealmSwift: TargetDependency = .external(name: "RealmSwift")
}
