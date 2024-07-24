import ProjectDescription
import ProjectDescriptionHelpers

@_spi(Feature)
@_spi(Domain)
import DependencyPlugin

let project: Project = .makeTMABasedProject(
  module: Feature.HomeFeature,
  scripts: [],
  targets: [
    .sources,
    .interface,
    .tests,
    .testing,
    .example
  ],
  dependencies: [
    .interface: [
      .dependency(rootModule: Domain.self)
    ]
  ]
)