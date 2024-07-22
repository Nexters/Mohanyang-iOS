import ProjectDescription
import ProjectDescriptionHelpers

@_spi(Domain)
@_spi(Core)
import DependencyPlugin

let project: Project = .makeTMABasedProject(
  module: Domain.PushService,
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
