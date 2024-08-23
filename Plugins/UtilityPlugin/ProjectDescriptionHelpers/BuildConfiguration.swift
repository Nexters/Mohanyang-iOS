//
//  BuildConfiguration.swift
//  UtilityPlugin
//
//  Created by MinseokKang on 2024/07/15.
//

import ProjectDescription

public enum BuildConfiguration: String, CaseIterable {
  case dev
  case prod
}

extension BuildConfiguration {
  public var name: String {
    return rawValue.uppercased()
  }
  
  public var configurationName: ConfigurationName {
    return ConfigurationName(stringLiteral: name)
  }
}
