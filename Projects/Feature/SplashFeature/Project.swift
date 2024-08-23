import ProjectDescription
import ProjectDescriptionHelpers

@_spi(Feature)
@_spi(Domain)
import DependencyPlugin

let project: Project = .makeTMABasedProject(
  module: Feature.SplashFeature,
  scripts: [],
  targets: [
    .sources
  ],
  dependencies: [
    .sources: [
      .dependency(rootModule: Domain.self)
    ]
  ]
)
