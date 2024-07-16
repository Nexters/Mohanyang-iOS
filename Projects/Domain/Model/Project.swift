import ProjectDescription
import ProjectDescriptionHelpers

@_spi(PomoNyang)
import DependencyPlugin

let project: Project = .project(
  module: PomoNyang.Domain.Model,
  scripts: [],
  targets: [
    .sources(.staticLibrary),
    .interface,
    .tests,
    .testing
  ],
  dependencies: []
)
