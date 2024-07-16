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

extension TargetDependency {
  /// ex) path: "Projects/Core/Logger", target: "LoggerInterface"
  public static func dependency<T: Modulable>(module: T, target: TargetType = .sources) -> TargetDependency {
    let moduleName = String(describing: module)
    return .project(target: "\(moduleName)\(target.postfixName)", path: .relativeToRoot("Projects/\(module.path)"))
  }
  
  public enum TargetType: Hashable {
    case sources
    case interface
    
    public var postfixName: String {
      switch self {
      case .sources:
        return ""
      case .interface:
        return "Interface"
      }
    }
  }
}
