//
//  TargetDependency+Modulable.swift
//  DependencyPlugin
//
//  Created by MinseokKang on 2024/07/15.
//


import ProjectDescription

public protocol Modulable: CaseIterable {
  var path: String { get }
}

extension Modulable where Self: RawRepresentable, Self.RawValue == String {
  public var path: String {
    return "\(Self.self)/\(self.rawValue)"
  }
}

extension TargetDependency {
  /// Modulable 모듈 의존성 연결
  public static func dependency<T: Modulable>(module: T, target: TargetType = .sources) -> TargetDependency {
    let moduleName = String(describing: module)
    return .project(target: "\(moduleName)\(target.suffixName)", path: .relativeToRoot("Projects/\(module.path)"))
  }
  
  /// Modulable 루트 의존성 연결
  public static func dependency<T: Modulable>(rootModule: T.Type) -> TargetDependency {
    let moduleName = String(describing: rootModule)
    return .project(target: "\(moduleName)", path: .relativeToRoot("Projects/\(moduleName)/\(moduleName)"))
  }
  
  public enum TargetType: Hashable {
    case sources
    case interface
    
    public var suffixName: String {
      switch self {
      case .sources:
        return ""
      case .interface:
        return "Interface"
      }
    }
  }
}
