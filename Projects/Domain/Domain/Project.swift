import ProjectDescription
import ProjectDescriptionHelpers

@_spi(Domain)
import DependencyPlugin

let project: Project = .makeRootProject(
  rootModule: Domain.self,
  scripts: [],
  product: .framework
)
