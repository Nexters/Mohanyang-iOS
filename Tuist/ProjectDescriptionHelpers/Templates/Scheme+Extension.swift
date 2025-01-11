//
//  Scheme+Extension.swift
//  ProjectDescriptionHelpers
//
//  Created by MinseokKang on 2024/07/15.
//

import UtilityPlugin
import ProjectDescription

extension Scheme {
  public static func makeAppScheme(
    target: TargetReference,
    config: BuildConfiguration
  ) -> Scheme {
    var runAction: RunAction
    
    switch config {
    case .dev:
      runAction = .runAction(
        configuration: config.configurationName,
        executable: target,
        arguments: .arguments(
          environmentVariables: [
            "OS_ACTIVITY_MODE": .environmentVariable(value: "enable", isEnabled: true),
            "IDEPreferLogStreaming": .environmentVariable(value: "YES", isEnabled: true)
          ],
          launchArguments: [
            .launchArgument(name: "-FIRDebugDisabled", isEnabled: true), // FirebaseSDK 로그 숨기기
            .launchArgument(name: "-noFIRAnalyticsDebugEnabled", isEnabled: true) // FirebaseAnalytics 로그 숨기기
          ]
        )
      )
    case .prod:
      runAction = .runAction(configuration: config.configurationName, executable: target)
    }
    
    return .scheme(
      name: "\(target.targetName)_\(config.name)",
      shared: true,
      buildAction: .buildAction(targets: [target]),
      runAction: runAction,
      archiveAction: .archiveAction(configuration: config.configurationName),
      profileAction: .profileAction(configuration: config.configurationName, executable: target),
      analyzeAction: .analyzeAction(configuration: config.configurationName)
    )
  }
  
  public static func makeExtensionScheme(
    extensionTarget: TargetReference,
    appTarget: TargetReference,
    config: BuildConfiguration
  ) -> Scheme {
    return .scheme(
      name: extensionTarget.targetName,
      shared: true,
      buildAction: .buildAction(targets: [extensionTarget, appTarget]), // 순서는 반드시 Extension 타겟이 첫번째가 되도록 할 것
      runAction: .runAction(configuration: config.configurationName),
      archiveAction: .archiveAction(configuration: config.configurationName),
      profileAction: .profileAction(configuration: config.configurationName),
      analyzeAction: .analyzeAction(configuration: config.configurationName)
    )
  }
}
