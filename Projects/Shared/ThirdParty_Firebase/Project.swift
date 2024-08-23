import ProjectDescription
import ProjectDescriptionHelpers

@_spi(Shared)
import DependencyPlugin

let project: Project = .makeProject(
  module: Shared.ThirdParty_Firebase,
  includeResource: false,
  scripts: [],
  product: .framework,
  dependencies: [
    DEP.XCFramework.FirebaseAnalytics,
    DEP.XCFramework.FirebaseCrashlytics,
    DEP.XCFramework.FirebaseInAppMessaging,
    DEP.XCFramework.FirebaseMessaging,
    DEP.XCFramework.FirebaseCore,
    DEP.XCFramework.FirebaseInstallations,
    DEP.XCFramework.FirebaseCoreInternal,
    DEP.XCFramework.GoogleAppMeasurement,
    DEP.XCFramework.GoogleDataTransport,
    DEP.XCFramework.GoogleUtilities,
    DEP.XCFramework.nanopb,
    DEP.XCFramework.FBLPromises,
    DEP.XCFramework.FirebaseABTesting,
    DEP.XCFramework.FirebasePerformance,
    DEP.XCFramework.FirebaseSessions,
    DEP.XCFramework.FirebaseRemoteConfig,
    DEP.XCFramework.FirebaseRemoteConfigInterop,
    DEP.XCFramework.Promises,
    DEP.XCFramework.FirebaseCoreExtension,
    DEP.XCFramework.FirebaseSharedSwift
  ]
)
