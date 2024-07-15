//
//  PathExtension.swift
//  UtilityPlugin
//
//  Created by MinseokKang on 2024/07/15.
//

import Foundation
import ProjectDescription

public extension ProjectDescription.Path {
  static let pomonyangAppXCConfig: Path = .relativeToRoot("XCConfig/App/PomoNyang.xcconfig")
  
  static func targetXCConfig(type: Product) -> Self {
    return .relativeToRoot("XCConfig/Target/\(type.rawValue).xcconfig")
  }
  
  static func projectXCConfig(type: BuildConfiguration) -> Self {
    return .relativeToRoot("XCConfig/Project/\(type.name).xcconfig")
  }
}
