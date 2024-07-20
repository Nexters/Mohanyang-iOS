import ProjectDescription
import ProjectDescriptionHelpers

@_spi(Shared)
import DependencyPlugin

let project: Project = .makeProject(
  module: Shared.ThirdParty_Realm,
  includeResource: false,
  scripts: [],
  product: .framework,
  dependencies: [
    DEP.XCFramework.Realm,
    DEP.XCFramework.RealmSwift
  ]
)
