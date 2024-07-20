//
//  DEP+SPMTarget.swift
//  DependencyPlugin
//
//  Created by MinseokKang on 2024/07/15.
//

import ProjectDescription

extension DEP {
  /// SwiftPackageManager for Target
  public enum SPMTarget {}
}

public extension DEP.SPMTarget {
  static let composableArchitecture: TargetDependency = .external(name: "ComposableArchitecture")
  static let dependencies: TargetDependency = .external(name: "Dependencies")
  static let riveRuntime: TargetDependency = .external(name: "RiveRuntime")
}
