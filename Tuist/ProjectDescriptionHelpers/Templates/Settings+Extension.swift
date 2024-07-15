//
//  Settings+Extension.swift
//  ProjectDescriptionHelpers
//
//  Created by MinseokKang on 2024/07/15.
//

import UtilityPlugin
import ProjectDescription

extension ProjectDescription.Settings {
  public static func appTargetSettings(xcconfig: Path) -> Self {
    let prodConfig = BuildConfiguration.prod
    let devConfig = BuildConfiguration.dev
    
    return .settings(
      configurations: [
        .debug(
          name: devConfig.configurationName,
          settings: [:]
            .otherSwiftFlags(["$(inherited)", "-D\(devConfig.name)"])
            .swiftActiveCompilationConditions([devConfig.name, "DEBUG"])
          ,
          xcconfig: xcconfig
        ),
        .release(
          name: prodConfig.configurationName,
          settings: [:]
            .otherSwiftFlags(["$(inherited)", "-D\(prodConfig.name)"])
            .swiftActiveCompilationConditions([prodConfig.name])
          ,
          xcconfig: xcconfig
        )
      ],
      defaultSettings: .essential
    )
  }
  
  public static var projectSettings: Self {
    let devConfig = BuildConfiguration.dev
    let prodConfig = BuildConfiguration.prod
    
    return .settings(
      configurations: [
        .debug(
          name: devConfig.configurationName,
          xcconfig: .projectXCConfig(type: devConfig)
        ),
        .release(
          name: prodConfig.configurationName,
          xcconfig: .projectXCConfig(type: prodConfig)
        )
      ],
      defaultSettings: .essential
    )
  }
  
  public static func targetSettings(product: Product) -> Self {
    let devConfig = BuildConfiguration.dev
    let prodConfig = BuildConfiguration.prod
    
    return .settings(
      configurations: [
        .debug(
          name: devConfig.configurationName,
          settings: [:]
            .otherSwiftFlags(["$(inherited)", "-D\(devConfig.name)"])
            .swiftActiveCompilationConditions([devConfig.name, "DEBUG"])
          ,
          xcconfig: .targetXCConfig(type: product)
        ),
        .release(
          name: prodConfig.configurationName,
          settings: [:]
            .otherSwiftFlags(["$(inherited)", "-D\(prodConfig.name)"])
            .swiftActiveCompilationConditions([prodConfig.name])
          ,
          xcconfig: .targetXCConfig(type: product)
        )
      ],
      defaultSettings: .essential
    )
  }
  
  public static var packageSettings: Self {
    let devConfig = BuildConfiguration.dev
    let prodConfig = BuildConfiguration.prod
    
    return .settings(
      base: [
        "EXCLUDED_ARCHS[sdk=iphonesimulator*]": "x86_64"
      ],
      configurations: [
        .debug(name: devConfig.configurationName),
        .release(name: prodConfig.configurationName)
      ],
      defaultSettings: .essential
    )
  }
}
