import ProjectDescription
import ProjectDescriptionHelpers

@_spi(Shared)
import DependencyPlugin

let project: Project = .makeTMABasedProject(
  module: Shared.Logger,
  scripts: [],
  targets: [
    .sources
  ],
  dependencies: [:]
)
