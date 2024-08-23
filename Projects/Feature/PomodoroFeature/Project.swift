//
//  Project.swift
//  PomodoroFeatureManifests
//
//  Created by devMinseok on 8/18/24.
//

import ProjectDescription
import ProjectDescriptionHelpers

@_spi(Feature)
@_spi(Domain)
import DependencyPlugin

let project: Project = .makeTMABasedProject(
  module: Feature.PomodoroFeature,
  scripts: [],
  targets: [
    .sources,
    .tests,
    .testing,
    .example
  ],
  dependencies: [
    .sources: [
      .dependency(rootModule: Domain.self)
    ]
  ]
)
