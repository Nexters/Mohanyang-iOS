//
//  Project.swift
//  LAPomodoroFeatureManifests
//
//  Created by MinseokKang on 11/23/24.
//

import ProjectDescription
import ProjectDescriptionHelpers

@_spi(Feature)
@_spi(Domain)
@_spi(Shared)
import DependencyPlugin

let project: Project = .makeTMABasedProject(
  module: Feature.LAPomodoroFeature,
  scripts: [],
  targets: [
    .sources,
    .example
  ],
  dependencies: [
    .sources: [
      .dependency(module: Domain.PomodoroService, target: .interface),
      .dependency(module: Shared.DesignSystem)
    ]
  ]
)
