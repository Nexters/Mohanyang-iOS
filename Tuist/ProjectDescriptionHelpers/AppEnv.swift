//
//  AppEnv
//  ProjectDescriptionHelpers
//
//  Created by MinseokKang on 2024/07/15.
//

import Foundation

import ProjectDescription
import UtilityPlugin

/// 프로젝트에서 공통적으로 사용하는 환경정보
public enum AppEnv {
  public static func moduleBundleId(name: String) -> String {
    var moduleName = name.lowercased()
    let validCharacters = CharacterSet(charactersIn: "abcdefghijklmnopqrstuvwxyz0123456789.")
    moduleName = moduleName.components(separatedBy: validCharacters.inverted).joined(separator: "")
    return "com.pomonyang.mohanyang.\(moduleName)"
  }
  
  public static let organizationName: String = "PomoNyang"
  public static let deploymentTarget: DeploymentTargets = .iOS("17.0")
  public static let platform: Destinations = [.iPhone]
  
  public static let bundleId: String = "com.pomonyang.mohanyang"
}
