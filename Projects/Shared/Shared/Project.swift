import ProjectDescription
import ProjectDescriptionHelpers

@_spi(Shared)
import DependencyPlugin

let project: Project = .makeRootProject(
  rootModule: Shared.self,
  scripts: [],
  product: .framework
)
