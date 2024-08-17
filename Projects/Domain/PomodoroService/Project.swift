//
//  Project.swift
//  PomodoroServiceManifests
//
//  Created by devMinseok on 8/17/24.
//

import ProjectDescription
import ProjectDescriptionHelpers

@_spi(Domain)
@_spi(Core)
import DependencyPlugin

let project: Project = .makeTMABasedProject(
  module: Domain.PomodoroService,
  scripts: [],
  targets: [
    .sources,
    .interface
  ],
  dependencies: [
    .interface: [
      .dependency(rootModule: Core.self)
    ]
  ]
)
