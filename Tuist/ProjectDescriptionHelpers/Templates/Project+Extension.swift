//
//  Project+Extension.swift
//  ProjectDescriptionHelpers
//
//  Created by MinseokKang on 2024/07/15.
//

import ProjectDescription
import UtilityPlugin
import DependencyPlugin

extension Project {
  public static func project<T: Modulable>(
    module: T,
    options: Project.Options = .options(disableSynthesizedResourceAccessors: true),
    packages: [Package] = [],
    infoPlist: InfoPlist = .default,
    includeResource: Bool? = nil,
    scripts: [TargetScript],
    targets: Set<TargetType>, // [.sources(.staticLibrary), .interface, .tests, .testing, .example],
    dependencies: [TargetDependency],
    schemes: [Scheme] = [],
    resourceSynthesizers: [ResourceSynthesizer] = []
  ) -> Project {
    let name = String(describing: module)
    var projectTargets: [Target] = []
    targets.forEach { targetType in
      let targetName = "\(name)\(targetType.postfixName)"
      
      switch targetType {
        case .sources(let machOType):
          let resources: ResourceFileElements? = if let includeResource {
            includeResource ? ["Resources/**"] : nil
          } else {
            machOType.isResourceRequired ? ["Resources/**"] : nil
          }
          let target: Target = .target(
            name: targetName,
            product: machOType,
            infoPlist: infoPlist,
            sources: ["Sources/**/*.swift"],
            resources: resources,
            scripts: scripts,
            dependencies: [
              targets.contains(.interface) ? [.target(name: "\(name)Interface")] : [],
              dependencies
            ].flatMap { $0 }
          )
          projectTargets.append(target)
          
        case .interface:
          let target: Target = .target(
            name: targetName,
            product: .staticLibrary,
            infoPlist: infoPlist,
            sources: ["Interface/**/*.swift"],
            resources: nil,
            scripts: [],
            dependencies: []
          )
          projectTargets.append(target)
          
        case .tests:
          let target: Target = .target(
            name: targetName,
            product: .unitTests,
            infoPlist: infoPlist,
            sources: ["Tests/**/*.swift"],
            resources: nil,
            scripts: [],
            dependencies: [
              [.target(name: "\(name)")],  // sources 의존성 연결
              targets.contains(.testing) ? [.target(name: "\(name)Testing")] : []
            ].flatMap { $0 }
          )
          projectTargets.append(target)
          
        case .testing:
          let target: Target = .target(
            name: targetName,
            product: .framework,
            infoPlist: infoPlist,
            sources: ["Testing/**/*.swift"],
            resources: nil,
            scripts: [],
            dependencies: targets.contains(.interface) ? [.target(name: "\(name)Interface")] : []
          )
          projectTargets.append(target)
          
        case .example:
          let target: Target = .target(
            name: targetName,
            product: .app,
            infoPlist: InfoPlist.Example.app(name: targetName),
            sources: ["Example/Sources/**/*.swift"],
            resources: ["Example/Resources/**"],
            scripts: [.reveal(target: .dev)],
            dependencies: [
              [.target(name: "\(name)")], // sources 의존성 연결
              targets.contains(.testing) ? [.target(name: "\(name)Testing")] : []
            ].flatMap { $0 }
          )
          projectTargets.append(target)
          
        case .preview:
          let target: Target = .target(
            name: targetName,
            product: .framework,
            infoPlist: infoPlist,
            sources: ["Preview/Sources/**/*.swift"],
            resources: ["Preview/Resources/**"],
            scripts: [],
            dependencies: [
              .target(name: "\(name)") // sources 의존성 연결
            ]
          )
          projectTargets.append(target)
      }
    }
    
    return .init(
      name: name,
      organizationName: AppEnv.organizationName,
      options: options,
      packages: packages,
      settings: .projectSettings,
      targets: projectTargets,
      schemes: schemes,
      fileHeaderTemplate: nil,
      additionalFiles: [],
      resourceSynthesizers: resourceSynthesizers
    )
  }
}

extension Project {
  /// based on µFeatures Architecture + Preview
  public enum TargetType: Hashable {
    /// Feature 소스코드 타겟
    case sources(Product)
    /// Feature 소스코드의 인터페이스
    case interface
    /// 테스트를 위한 타겟
    case tests
    /// tests에서 사용할 테스트 데이터를 위한 타겟
    case testing
    /// 데모앱을 위한 타겟
    case example
    /// Xcode Preview를 위한 타겟
    case preview
    
    public var postfixName: String {
      switch self {
        case .sources:
          return ""
        case .interface:
          return "Interface"
        case .tests:
          return "Tests"
        case .testing:
          return "Testing"
        case .example:
          return "Example"
        case .preview:
          return "Preview"
      }
    }
    
    // associated value 상관없이 case로 hash하면 됨
    public func hash(into hasher: inout Hasher) {
      switch self {
        case .sources:
          hasher.combine(0)
        case .interface:
          hasher.combine(1)
        case .tests:
          hasher.combine(2)
        case .testing:
          hasher.combine(3)
        case .example:
          hasher.combine(4)
        case .preview:
          hasher.combine(5)
      }
    }
  }
}
