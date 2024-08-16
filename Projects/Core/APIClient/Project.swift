//
//  Project.swift
//  APIClientManifests
//
//  Created by devMinseok on 8/16/24.
//

import ProjectDescription
import ProjectDescriptionHelpers

@_spi(Core)
@_spi(Shared)
import DependencyPlugin

let project: Project = .makeTMABasedProject(
  module: Core.APIClient,
  scripts: [],
  targets: [
    .sources,
    .interface,
    .tests,
    .testing
  ],
  dependencies: [
    .interface: [
      .dependency(rootModule: Shared.self),
      .dependency(module: Core.KeychainClient, target: .interface)
    ]
  ]
)
