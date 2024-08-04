import ProjectDescription
import ProjectDescriptionHelpers

@_spi(Core)
@_spi(Domain)
import DependencyPlugin

let project: Project = .makeTMABasedProject(
  module: Domain.AppService,
  scripts: [],
  targets: [
    .sources
  ],
  dependencies: [
    .sources: [
      .dependency(rootModule: Core.self)
    ]
  ]
)
