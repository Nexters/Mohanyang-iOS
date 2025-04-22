//
//  Project.swift
//  AnalyticsClientManifests
//
//  Created by devMinseok on 4/22/25.
//

import ProjectDescription
import ProjectDescriptionHelpers

@_spi(Core)
@_spi(Shared)
import DependencyPlugin

let project: Project = .makeTMABasedProject(
  module: Core.AnalyticsClient,
  scripts: [],
  targets: [
    .sources,
    .interface
  ],
  dependencies: [
    .interface: [
      .dependency(rootModule: Shared.self)
    ]
  ]
)
