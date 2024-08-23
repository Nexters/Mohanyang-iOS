import ProjectDescription
import ProjectDescriptionHelpers

@_spi(Shared)
import DependencyPlugin

let project: Project = .makeTMABasedProject(
  module: Shared.Utils,
  scripts: [],
  targets: [
    .sources
  ],
  dependencies: [:]
)
