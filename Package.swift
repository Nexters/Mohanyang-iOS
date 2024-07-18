// swift-tools-version: 5.9
import PackageDescription

#if TUIST
import struct ProjectDescription.PackageSettings
import ProjectDescriptionHelpers

let packageSettings: PackageSettings = .init(
  productTypes: [
    "KakaoSDKCommon": .framework,
    "KakaoSDKAuth": .framework,
//    "KakaoSDKUser": .framework,
//    "KakaoSDKTalk": .framework,
//    "KakaoSDKShare": .framework,
//    "KakaoSDKNavi": .framework,
//    "KakaoSDKTemplate": .framework,
  ],
  baseSettings: .packageSettings
)
#endif

let package: Package = .init(
  name: "PomoNyang",
  platforms: [.iOS(.v17)],
  dependencies: [
    .package(url: "https://github.com/pointfreeco/swift-composable-architecture.git", exact: "1.11.2"),
    .package(url: "https://github.com/kakao/kakao-ios-sdk.git", exact: "2.22.0")
  ]
)
