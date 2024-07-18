import ProjectDescription
import ProjectDescriptionHelpers

@_spi(PomoNyang)
import DependencyPlugin

let project: Project = .project(
  module: PomoNyang.Shared.DesignSystem,
  includeResource: true,
  scripts: [],
  targets: [
    .sources,
    .interface,
    .tests,
    .testing
  ],
  dependencies: []
)
