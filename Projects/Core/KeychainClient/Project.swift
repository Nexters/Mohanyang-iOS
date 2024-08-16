//
//  Project.swift
//  KeychainClientManifests
//
//  Created by devMinseok on 8/16/24.
//

import ProjectDescription
import ProjectDescriptionHelpers

@_spi(Core)
@_spi(Shared)
import DependencyPlugin

let project: Project = .makeTMABasedProject(
  module: Core.KeychainClient,
  scripts: [],
  targets: [
    .sources,
    .interface,
    .tests
  ],
  dependencies: [
    .interface: [
      .dependency(rootModule: Shared.self)
    ]
  ]
)
