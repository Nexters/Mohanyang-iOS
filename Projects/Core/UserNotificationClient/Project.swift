//
//  Project.swift
//  UserNotificationClientManifests
//
//  Created by devMinseok on 8/16/24.
//

import ProjectDescription
import ProjectDescriptionHelpers

@_spi(Core)
@_spi(Shared)
import DependencyPlugin

let project: Project = .makeTMABasedProject(
  module: Core.UserNotificationClient,
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
