import ProjectDescription
import ProjectDescriptionHelpers

@_spi(Core)
@_spi(Shared)
import DependencyPlugin

let project: Project = .makeTMABasedProject(
  module: Core.KeychainClient,
  scripts: [],
  targets: [
    .sources,
    .interface
  ],
  dependencies: [
    .sources: [
      
    ],
    .interface: [
      .dependency(rootModule: Shared.self),
    ]
  ]
)
