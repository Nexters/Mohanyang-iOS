import ProjectDescription
import ProjectDescriptionHelpers

@_spi(Feature)
import DependencyPlugin

let project: Project = .makeRootProject(
  rootModule: Feature.self,
  scripts: [],
  product: .framework
)
