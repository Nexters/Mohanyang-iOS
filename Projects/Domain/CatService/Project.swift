import ProjectDescription
import ProjectDescriptionHelpers

@_spi(Domain)
@_spi(Core)
import DependencyPlugin

let project: Project = .makeTMABasedProject(
  module: Domain.CatService,
  scripts: [],
  targets: [
    .sources,
    .interface
  ],
  dependencies: [
    .interface: [
      .dependency(rootModule: Core.self)
    ]
  ]
)
