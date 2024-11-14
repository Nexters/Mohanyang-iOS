import ProjectDescription
import ProjectDescriptionHelpers

@_spi(Feature)
@_spi(Domain)
import DependencyPlugin

let project: Project = .makeTMABasedProject(
  module: Feature.ErrorFeature,
  scripts: [],
  targets: [
    .sources,
    .tests,
    .testing,
    .example
  ],
  dependencies: [
    .sources: [
      .dependency(rootModule: Domain.self)
    ]
  ]
)
