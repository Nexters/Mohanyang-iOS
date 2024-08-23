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
  /// TMA 기반 프로젝트 생성
  public static func makeTMABasedProject<T: Modulable>(
    module: T,
    options: Project.Options = .options(disableSynthesizedResourceAccessors: true),
    packages: [Package] = [],
    infoPlist: InfoPlist = .default,
    includeResource: Bool = false,
    scripts: [TargetScript],
    targets: Set<TargetType>, // [.sources, .interface, .tests, .testing, .example]
    dependencies: [TargetType: [TargetDependency]],
    schemes: [Scheme] = [],
    resourceSynthesizers: [ResourceSynthesizer] = []
  ) -> Project {
    let name = String(describing: module)
    var projectTargets: [Target] = []
    targets.forEach { targetType in
      let targetName = "\(name)\(targetType.suffixName)"
      let currentDependencies = dependencies[targetType] ?? []
      
      switch targetType {
      case .sources:
        let product: Product = if includeResource {
          .staticFramework // currentConfig == .dev ? .framework : .staticFramework
        } else {
          .staticLibrary // currentConfig == .dev ? .framework : .staticLibrary
        }
        let resources: ResourceFileElements? = includeResource ? ["Resources/**"] : nil
        let interfaceDependency: [TargetDependency] = targets.contains(.interface) ? [.target(name: "\(name)Interface")] : []
        let dependencies: [TargetDependency] = (interfaceDependency + currentDependencies).compactMap { $0 }
        let target: Target = .target(
          name: targetName,
          product: product,
          infoPlist: infoPlist,
          sources: ["Sources/**/*.swift"],
          resources: resources,
          scripts: scripts,
          dependencies: dependencies
        )
        projectTargets.append(target)
        
      case .interface:
        let product: Product = .staticLibrary //currentConfig == .dev ? .framework : .staticLibrary
        let target: Target = .target(
          name: targetName,
          product: product,
          infoPlist: infoPlist,
          sources: ["Interface/**/*.swift"],
          resources: nil,
          scripts: [],
          dependencies: currentDependencies
        )
        projectTargets.append(target)
        
      case .tests:
        let sourcesDependency: [TargetDependency] = [.target(name: "\(name)")]
        let testingDependency: [TargetDependency] = targets.contains(.testing) ? [.target(name: "\(name)Testing")] : []
        let dependencies: [TargetDependency] = (sourcesDependency + testingDependency + currentDependencies).compactMap { $0 }
        let target: Target = .target(
          name: targetName,
          product: .unitTests,
          infoPlist: infoPlist,
          sources: ["Tests/**/*.swift"],
          resources: nil,
          scripts: [],
          dependencies: dependencies
        )
        projectTargets.append(target)
        
      case .testing:
        let product: Product = .staticFramework // currentConfig == .dev ? .framework : .staticFramework
        let interfaceDependency: [TargetDependency] = targets.contains(.interface) ? [.target(name: "\(name)Interface")] : []
        let dependencies: [TargetDependency] = (interfaceDependency + currentDependencies).compactMap { $0 }
        let target: Target = .target(
          name: targetName,
          product: product,
          infoPlist: infoPlist,
          sources: ["Testing/**/*.swift"],
          resources: nil,
          scripts: [],
          dependencies: dependencies
        )
        projectTargets.append(target)
        
      case .example:
        let sourcesDependency: [TargetDependency] = [.target(name: "\(name)")]
        let testingDependency: [TargetDependency] = targets.contains(.testing) ? [.target(name: "\(name)Testing")] : []
        let dependencies: [TargetDependency] = (sourcesDependency + testingDependency + currentDependencies).compactMap { $0 }
        let target: Target = .target(
          name: targetName,
          product: .app,
          infoPlist: InfoPlist.Example.app(name: targetName),
          sources: ["Example/Sources/**/*.swift"],
          resources: ["Example/Resources/**"],
          scripts: [.reveal(target: .dev)],
          dependencies: dependencies
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
  
  /// Modulable 모듈 프로젝트 생성
  public static func makeProject<T: Modulable>(
    module: T,
    options: Project.Options = .options(disableSynthesizedResourceAccessors: true),
    packages: [Package] = [],
    infoPlist: InfoPlist = .default,
    includeResource: Bool = false,
    scripts: [TargetScript],
    product: Product,
    dependencies: [TargetDependency],
    schemes: [Scheme] = [],
    resourceSynthesizers: [ResourceSynthesizer] = []
  ) -> Project {
    let targetName = String(describing: module)
    let resources: ResourceFileElements? = includeResource ? ["Resources/**"] : nil
    let target: Target = .target(
      name: targetName,
      product: product,
      infoPlist: infoPlist,
      sources: ["Sources/**/*.swift"],
      resources: resources,
      scripts: scripts,
      dependencies: dependencies
    )
    return .init(
      name: targetName,
      organizationName: AppEnv.organizationName,
      options: options,
      packages: packages,
      settings: .projectSettings(),
      targets: [target],
      schemes: schemes,
      fileHeaderTemplate: nil,
      additionalFiles: [],
      resourceSynthesizers: resourceSynthesizers
    )
  }
  
  /// Modulable 루트 프로젝트 생성
  public static func makeRootProject<T: Modulable>(
    rootModule: T.Type,
    options: Project.Options = .options(disableSynthesizedResourceAccessors: true),
    packages: [Package] = [],
    infoPlist: InfoPlist = .default,
    scripts: [TargetScript],
    product: Product,
    schemes: [Scheme] = [],
    resourceSynthesizers: [ResourceSynthesizer] = []
  )  -> Project where T: RawRepresentable, T.RawValue == String {
    let targetName = String(describing: T.self)
    let childTargets = T.allCases
    let dependencies: [TargetDependency] = childTargets.map { .dependency(module: $0) }
    
    let target: Target = .target(
      name: targetName,
      product: product,
      infoPlist: infoPlist,
      sources: ["Sources/**/*.swift"],
      resources: nil,
      scripts: scripts,
      dependencies: dependencies
    )
    return .init(
      name: targetName,
      organizationName: AppEnv.organizationName,
      options: options,
      packages: packages,
      settings: .projectSettings(),
      targets: [target],
      schemes: schemes,
      fileHeaderTemplate: nil,
      additionalFiles: [],
      resourceSynthesizers: resourceSynthesizers
    )
  }
}

extension Project {
  /// based on TMA architecture
  /// - https://docs.tuist.io/guides/develop/projects/tma-architecture
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
