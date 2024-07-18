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
    includeResource: Bool = false,
    scripts: [TargetScript],
    targets: Set<TargetType>, // [.sources, .interface, .tests, .testing, .example],
    dependencies: [TargetDependency],
    schemes: [Scheme] = [],
    resourceSynthesizers: [ResourceSynthesizer] = []
  ) -> Project {
    let name = String(describing: module)
    var projectTargets: [Target] = []
    targets.forEach { targetType in
      let targetName = "\(name)\(targetType.suffixName)"
      
      switch targetType {
      case .sources:
        let product: Product = if includeResource {
          currentConfig == .dev ? .framework : .staticFramework
        } else {
          currentConfig == .dev ? .framework : .staticLibrary
        }
        let resources: ResourceFileElements? = includeResource ? ["Resources/**"] : nil
        let target: Target = .target(
          name: targetName,
          product: product,
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
        let product: Product = currentConfig == .dev ? .framework : .staticLibrary
        let target: Target = .target(
          name: targetName,
          product: product,
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
      }
    }
    
    return .init(
      name: name,
      organizationName: AppEnv.organizationName,
      options: options,
      packages: packages,
      settings: .projectSettings(),
      targets: projectTargets,
      schemes: schemes,
      fileHeaderTemplate: nil,
      additionalFiles: [],
      resourceSynthesizers: resourceSynthesizers
    )
  }
}

extension Project {
  /// based on µFeatures Architecture
  public enum TargetType: Hashable {
    /// Feature 소스코드 타겟
    case sources
    /// Feature 소스코드의 인터페이스
    case interface
    /// 테스트를 위한 타겟
    case tests
    /// tests에서 사용할 테스트 데이터를 위한 타겟
    case testing
    /// 데모앱을 위한 타겟
    case example
    
    public var suffixName: String {
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
      }
    }
  }
}
