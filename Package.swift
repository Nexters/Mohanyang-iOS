// swift-tools-version: 5.9
import PackageDescription

#if TUIST
import struct ProjectDescription.PackageSettings
import ProjectDescriptionHelpers

let packageSettings: PackageSettings = .init(
  productTypes: [:],
  baseSettings: .packageSettings
)
#endif

let package: Package = .init(
  name: "Mohanyang",
  platforms: [.iOS(.v17)],
  dependencies: [
    .package(url: "https://github.com/pointfreeco/swift-composable-architecture.git", exact: "1.11.2"),
    .package(url: "https://github.com/pointfreeco/swift-dependencies.git", exact: "1.3.3"),
    .package(url: "https://github.com/rive-app/rive-ios.git", exact: "5.15.1")
  ]
)
