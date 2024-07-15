import ProjectDescription
import ProjectDescriptionHelpers

@_spi(PomoNyang)
import DependencyPlugin

let project: Project = .project(
  module: PomoNyang.Shared.Utils,
  scripts: [],
  targets: [
    .sources(.staticLibrary),
    .interface,
    .tests,
    .testing,
    .example
  ],
  dependencies: []
)
