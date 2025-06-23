// swift-tools-version: 6.0
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
    .package(url: "https://github.com/pointfreeco/swift-composable-architecture.git", exact: "1.16.1"),
    .package(url: "https://github.com/pointfreeco/swift-dependencies.git", from: "1.4.0"),
    .package(url: "https://github.com/rive-app/rive-ios.git", exact: "5.15.1"),
    .package(url: "https://github.com/airbnb/lottie-spm.git", exact: "4.5.0"),
    .package(url: "https://github.com/Datadog/dd-sdk-ios.git", exact: "2.16.0"),
    .package(url: "https://github.com/firebase/firebase-ios-sdk.git", exact: "11.14.0"),
    .package(url: "https://github.com/realm/realm-swift.git", exact: "20.0.2")
  ]
)
