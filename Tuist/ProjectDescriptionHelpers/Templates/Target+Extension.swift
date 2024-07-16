//
//  Target+Extension.swift
//  ProjectDescriptionHelpers
//
//  Created by MinseokKang on 2024/07/15.
//

import ProjectDescription
import UtilityPlugin

extension Target {
  static func target(
    name: String,
    product: Product,
    infoPlist: InfoPlist,
    sources: SourceFilesList,
    resources: ResourceFileElements?,
    scripts: [TargetScript],
    dependencies: [TargetDependency]
  ) -> Target {
    return .target(
      name: name,
      destinations: AppEnv.platform,
      product: product,
      productName: nil,
      bundleId: AppEnv.moduleBundleId(name: name),
      deploymentTargets: AppEnv.deploymentTarget,
      infoPlist: infoPlist,
      sources: sources,
      resources: resources,
      copyFiles: nil,
      headers: nil,
      entitlements: nil,
      scripts: scripts,
      dependencies: dependencies,
      settings: .targetSettings(product: product),
      coreDataModels: [],
      environmentVariables: [:],
      launchArguments: [],
      additionalFiles: [],
      buildRules: []
    )
  }
}
