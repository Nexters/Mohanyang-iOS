//
//  Settings+Extension.swift
//  ProjectDescriptionHelpers
//
//  Created by MinseokKang on 2024/07/15.
//

import UtilityPlugin
import ProjectDescription

extension ProjectDescription.Settings {
  /// 프로젝트 설정
  public static func projectSettings(
    xcconfig: Path? = nil
  ) -> Self {
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
  
  /// 타겟 설정
  public static func targetSettings(
    product: Product
  ) -> Self {
    let devConfig = BuildConfiguration.dev
    let prodConfig = BuildConfiguration.prod
    
    return .settings(
      configurations: [
        .debug(
          name: devConfig.configurationName,
          xcconfig: .targetXCConfig(type: product)
        ),
        .release(
          name: prodConfig.configurationName,
          xcconfig: .targetXCConfig(type: product)
        )
      ],
      defaultSettings: .essential
    )
  }
  
  /// 패키지 설정
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
