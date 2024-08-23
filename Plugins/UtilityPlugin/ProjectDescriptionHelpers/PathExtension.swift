//
//  PathExtension.swift
//  UtilityPlugin
//
//  Created by MinseokKang on 2024/07/15.
//

import Foundation
import ProjectDescription

extension ProjectDescription.Path {
  public static let mohanyangAppXCConfig: Path = .relativeToRoot("XCConfig/Project/Mohanyang.xcconfig")
  
  public static func targetXCConfig(type: Product) -> Self {
    return .relativeToRoot("XCConfig/Target/\(type.rawValue).xcconfig")
  }
}
