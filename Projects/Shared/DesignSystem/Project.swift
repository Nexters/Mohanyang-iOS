import ProjectDescription
import ProjectDescriptionHelpers

@_spi(Shared)
import DependencyPlugin

let project: Project = .makeTMABasedProject(
  module: Shared.DesignSystem,
  includeResource: true,
  scripts: [],
  targets: [
    .sources,
    .interface,
    .tests,
    .testing
  ],
  dependencies: [:]
)
