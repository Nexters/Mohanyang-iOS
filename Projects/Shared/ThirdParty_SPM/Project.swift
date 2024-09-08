import ProjectDescription
import ProjectDescriptionHelpers

@_spi(Shared)
import DependencyPlugin

let project: Project = .makeProject(
  module: Shared.ThirdParty_SPM,
  includeResource: false,
  scripts: [],
  product: .framework,
  dependencies: [
    DEP.SPMTarget.composableArchitecture,
    DEP.SPMTarget.dependencies,
    DEP.SPMTarget.riveRuntime,
    DEP.SPMTarget.lottie,
    DEP.SPMTarget.datadogCore,
    DEP.SPMTarget.datadogRUM
  ]
)
