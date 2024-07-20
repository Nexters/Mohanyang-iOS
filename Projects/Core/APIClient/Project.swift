import ProjectDescription
import ProjectDescriptionHelpers

@_spi(Core)
@_spi(Shared)
import DependencyPlugin

let project: Project = .makeTMABasedProject(
  module: Core.APIClient,
  scripts: [],
  targets: [
    .sources,
    .interface,
    .tests,
    .testing
  ],
  dependencies: [
    .sources: [
//      .dependency(module: Shared.Utils)
    ],
    .interface: [
      .dependency(rootModule: Shared.self),
    ]
  ]
)
