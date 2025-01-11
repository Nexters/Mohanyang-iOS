//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by MinseokKang on 2024/07/15.
//

import ProjectDescription
import ProjectDescriptionHelpers

@_spi(Feature)
@_spi(Shared)
import DependencyPlugin

// MARK: - ApplicationExtension

let widgetExtensionTargetName = "WidgetExtension"
let widgetExtensionTarget: Target = .target(
  name: widgetExtensionTargetName,
  destinations: AppEnv.platform,
  product: .appExtension,
  bundleId: AppEnv.bundleId + ".widgetextension",
  deploymentTargets: AppEnv.deploymentTarget,
  infoPlist: InfoPlist.Mohanyang.widgetExtension,
  sources: [
    "ApplicationExtension/WidgetExtension/**"
  ],
  entitlements: Entitlements.Mohanyang.widgetExtension,
  dependencies: [
    .dependency(module: Feature.LAPomodoroFeature)
  ],
  settings: .targetSettings(product: .appExtension)
)


// MARK: - Target

let scripts: [TargetScript] = if currentConfig == .dev {
  [.reveal(target: .dev)]
} else {
  [.firebaseCrashlytics]
}

let appTargetName = "Mohanyang"
let appTarget: Target = .target(
  name: appTargetName,
  destinations: AppEnv.platform,
  product: .app,
  bundleId: AppEnv.bundleId,
  deploymentTargets: AppEnv.deploymentTarget,
  infoPlist: InfoPlist.Mohanyang.app,
  sources: [
    "Sources/**"
  ],
  resources: .resources(
    [
      "GoogleService-Info.plist",
      "Resources/\(currentConfig.name)/**"
    ],
    privacyManifest: .mohanyang
  ),
  entitlements: Entitlements.Mohanyang.app,
  scripts: scripts,
  dependencies: [
    .dependency(rootModule: Feature.self),
    .target(widgetExtensionTarget)
  ],
  settings: .targetSettings(product: .app)
)

// MARK: - Scheme

let appScheme = Scheme.makeAppScheme(
  target: TargetReference(stringLiteral: appTargetName),
  config: currentConfig
)

let widgetExtensionScheme = Scheme.makeExtensionScheme(
  extensionTarget: TargetReference(stringLiteral: widgetExtensionTargetName),
  appTarget: TargetReference(stringLiteral: appTargetName),
  config: currentConfig
)


// MARK: - Project

let project: Project = .init(
  name: "App",
  organizationName: AppEnv.organizationName,
  options: .options(automaticSchemesOptions: .disabled, disableSynthesizedResourceAccessors: true),
  settings: .projectSettings(xcconfig: .mohanyangAppXCConfig),
  targets: [appTarget, widgetExtensionTarget],
  schemes: [appScheme, widgetExtensionScheme]
)
