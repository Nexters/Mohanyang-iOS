//
//  Environment.swift
//  ProjectDescriptionHelpers
//
//  Created by devMinseok on 6/28/24.
//

import UtilityPlugin
import ProjectDescription

/// "TUIST_ROOT_DIR" 환경 변수값
public let rootDirectory = Environment.rootDir.getString(default: "SRCROOT")

/// "TUIST_BUILD_CONFIG" 환경 변수값
public let buildConfiguration = Environment.buildConfig.getString(default: "DEV")

/// 현재 빌드 환경
public let currentConfig = BuildConfiguration(rawValue: buildConfiguration.lowercased()) ?? .dev
