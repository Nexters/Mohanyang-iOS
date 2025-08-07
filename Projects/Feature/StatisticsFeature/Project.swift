//
//  Project.swift
//  StatisticsFeatureManifests
//
//  Created by MinseokKang on 7/7/25.
//

import ProjectDescription
import ProjectDescriptionHelpers

@_spi(Feature)
@_spi(Domain)
@_spi(Shared)
import DependencyPlugin

let project: Project = .makeTMABasedProject(
  module: Feature.StatisticsFeature,
  scripts: [],
  targets: [
    .sources,
    .example
  ],
  dependencies: [
    .sources: [
      .dependency(module: Domain.PomodoroService, target: .interface)
    ]
  ]
)
