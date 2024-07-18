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
  // MARK: - Architecture
  static let ComposableArchitecture: TargetDependency = .external(name: "ComposableArchitecture")
  
  // MARK: - KakaoSDK
  static let KakaoSDKCommon: TargetDependency = .external(name: "KakaoSDKCommon")
  static let KakaoSDKAuth: TargetDependency = .external(name: "KakaoSDKAuth")
  static let KakaoSDKUser: TargetDependency = .external(name: "KakaoSDKUser")
  static let KakaoSDKTalk: TargetDependency = .external(name: "KakaoSDKTalk")
  static let KakaoSDKShare: TargetDependency = .external(name: "KakaoSDKShare")
  static let KakaoSDKNavi: TargetDependency = .external(name: "KakaoSDKNavi")
  static let KakaoSDKTemplate: TargetDependency = .external(name: "KakaoSDKTemplate")
  static let KakaoAdSDK: TargetDependency = .external(name: "KakaoAdSDK")
}
