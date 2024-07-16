import ProjectDescription
import ProjectDescriptionHelpers

@_spi(PomoNyang)
import DependencyPlugin

let project: Project = .project(
  module: PomoNyang.Domain.AppService,
  scripts: [],
  targets: [
    .sources(.staticLibrary),
    .interface,
    .tests,
    .testing
  ],
  dependencies: [
    .dependency(module: PomoNyang.Core.APIClient),
    .dependency(module: PomoNyang.Domain.Model)
  ]
)
