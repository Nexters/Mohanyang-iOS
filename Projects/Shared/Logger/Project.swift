import ProjectDescription
import ProjectDescriptionHelpers

@_spi(PomoNyang)
import DependencyPlugin

let project: Project = .project(
  module: PomoNyang.Shared.Logger,
  scripts: [],
  targets: [
    .sources
  ],
  dependencies: []
)
