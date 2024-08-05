//
//  DesignSystemTesting.swift
//  DesignSystemManifests
//
//  Created by devMinseok on 8/5/24.
//

import ProjectDescription
import ProjectDescriptionHelpers

@_spi(Shared)
import DependencyPlugin

let project: Project = .makeTMABasedProject(
  module: Shared.DesignSystem,
  options: .options(
    disableSynthesizedResourceAccessors: false
  ),
  includeResource: true,
  scripts: [],
  targets: [
    .sources,
    .tests,
    .testing,
    .example
  ],
  dependencies: [:],
  resourceSynthesizers: [
    .fonts(), // for font
    .assets(), // for .xcassets,
    .files(extensions: ["mp4", "gif"])
  ]
)
