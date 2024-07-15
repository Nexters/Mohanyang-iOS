//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by MinseokKang on 2024/07/15.
//

import ProjectDescription
import ProjectDescriptionHelpers

@_spi(PomoNyang)
import DependencyPlugin

// MARK: - Target

let scripts: [TargetScript] = if currentConfig == .dev {
  [.reveal(target: .dev)]
} else {
  [.firebaseCrashlytics]
}

let appTargetName = "PomoNyang"
let appTarget: Target = .target(
  name: appTargetName,
  destinations: AppEnv.platform,
  product: .app,
  bundleId: AppEnv.bundleId,
  deploymentTargets: AppEnv.deploymentTarget,
  infoPlist: InfoPlist.PomoNyang.app,
  sources: [
    "Sources/**"
  ],
  resources: .resources(
    [
      "GoogleService-Info.plist",
      "Resources/\(currentConfig.name)/**"
    ],
    privacyManifest: .pomonyang
  ),
  entitlements: Entitlements.PomoNyang.app,
  scripts: scripts,
  dependencies: [
    .dependency(module: PomoNyang.Feature.AppFeature),
    .dependency(module: PomoNyang.Shared.DesignSystem)
  ],
  settings: .targetSettings(product: .app)
)

// MARK: - Scheme

let appScheme = Scheme.makeAppScheme(
  target: TargetReference(stringLiteral: appTargetName),
  config: currentConfig
)


// MARK: - Project

let project: Project = .init(
  name: "App",
  organizationName: AppEnv.organizationName,
  options: .options(automaticSchemesOptions: .disabled, disableSynthesizedResourceAccessors: true),
  settings: .projectSettings(xcconfig: .pomonyangAppXCConfig),
  targets: [appTarget],
  schemes: [appScheme]
)
