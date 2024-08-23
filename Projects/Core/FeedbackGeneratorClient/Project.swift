//
//  Project.swift
//  FeedbackGeneratorClientManifests
//
//  Created by devMinseok on 8/16/24.
//

import ProjectDescription
import ProjectDescriptionHelpers

@_spi(Core)
@_spi(Shared)
import DependencyPlugin

let project: Project = .makeTMABasedProject(
  module: Core.FeedbackGeneratorClient,
  scripts: [],
  targets: [
    .sources,
    .interface,
    .example
  ],
  dependencies: [
    .interface: [
      .dependency(rootModule: Shared.self)
    ]
  ]
)
