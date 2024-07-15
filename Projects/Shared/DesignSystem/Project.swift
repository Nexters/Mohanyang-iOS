import ProjectDescription
import ProjectDescriptionHelpers

@_spi(PomoNyang)
import DependencyPlugin

let project: Project = .project(
  module: PomoNyang.Shared.DesignSystem,
  scripts: [],
  targets: [
    .sources(.staticFramework),
    .interface,
    .tests,
    .testing,
    .example
  ],
  dependencies: []
)
