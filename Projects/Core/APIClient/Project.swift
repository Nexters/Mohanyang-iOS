import ProjectDescription
import ProjectDescriptionHelpers

@_spi(PomoNyang)
import DependencyPlugin

let project: Project = .project(
  module: PomoNyang.Core.APIClient,
  scripts: [],
  targets: [
    .sources,
    .interface,
    .tests,
    .testing
  ],
  dependencies: [
    .dependency(module: PomoNyang.Shared.Utils)
  ]
)
