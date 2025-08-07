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
    DEP.SPMTarget.FirebaseAnalytics,
    DEP.SPMTarget.FirebaseCrashlytics,
    DEP.SPMTarget.FirebaseMessaging,
    DEP.SPMTarget.FirebasePerformance
  ]
)
