//
//  InfoPlist+Mohanyang.swift
//  ProjectDescriptionHelpers
//
//  Created by MinseokKang on 2024/07/15.
//

import ProjectDescription

extension InfoPlist {
  public enum Mohanyang {
    public static var app: InfoPlist {
      return .dictionary([
        // MARK: - Environment Value
        
        "BASE_URL": "$(BASE_URL)",
        "DATADOG_APP_ID": "$(DATADOG_APP_ID)",
        "DATADOG_TOKEN": "$(DATADOG_TOKEN)",
        
        
        // MARK: - ThirdParty
        
        
        // MARK: - Security
        
        "ITSAppUsesNonExemptEncryption": false, // "수출 규정 관련 문서가 누락됨" 뜨지 않게 하기 위해 설정
        
        
        // MARK: - Core Foundation
        
        "CFBundleDevelopmentRegion": "ko_KR",
        "CFBundleDisplayName": "$(APP_NAME)",
        "CFBundleExecutable": "$(EXECUTABLE_NAME)",
        "CFBundleIdentifier": "$(PRODUCT_BUNDLE_IDENTIFIER)",
        "CFBundleInfoDictionaryVersion": "6.0",
        "CFBundleName": "$(PRODUCT_NAME)",
        "CFBundlePackageType": "APPL",
        "CFBundleShortVersionString": "$(MARKETING_VERSION)",
        "CFBundleVersion": "$(CURRENT_PROJECT_VERSION)",
        "CFBundleURLTypes": [],
        
        
        // MARK: - Launch Services
        
        "LSRequiresIPhoneOS": true,
        "LSApplicationQueriesSchemes": [],
        
        
        // MARK: - Live Activities
        
        "NSSupportsLiveActivities": true,
        
        
        // MARK: - BGTask
        
        "BGTaskSchedulerPermittedIdentifiers": [
          "\(AppEnv.bundleId).update_LiveActivity"
        ],
        "UIBackgroundModes": [
          "fetch",
          "processing"
        ],
        
        
        // MARK: - Cocoa
        
        "NSAppTransportSecurity": [
          "NSAllowsArbitraryLoads": true
        ],
        "NSBonjourServices": [
          "_dartobservatory._tcp"
        ],
//        "NSCameraUsageDescription": "",
//        "NSContactsUsageDescription": "",
//        "NSLocationWhenInUseUsageDescription": "",
//        "NSMicrophoneUsageDescription": "",
//        "NSPhotoLibraryUsageDescription": "",
//        "NSUserTrackingUsageDescription": "",
        
        
        // MARK: - UIKit
        
        "CoreSpotlightContinuation": true,
        "UIAppFonts": [
          "Pretendard-Bold.otf",
          "Pretendard-Medium.otf",
          "Pretendard-Regular.otf",
          "Pretendard-SemiBold.otf"
        ],
        "UILaunchStoryboardName": "LaunchScreen",
        "UIRequiredDeviceCapabilities": ["armv7"],
        "UIStatusBarHidden": true,
        "UIStatusBarStyle": "UIStatusBarStyleLightContent",
        "UISupportedInterfaceOrientations~iphone": ["UIInterfaceOrientationPortrait"],
        "UIUserInterfaceStyle": "Light"
      ])
    }
    
    public static var widgetExtension: InfoPlist {
      return .extendingDefault(with: [
        "CFBundleDisplayName": "$(APP_NAME)",
        "CFBundleShortVersionString": "$(MARKETING_VERSION)",
        "CFBundleVersion": "$(CURRENT_PROJECT_VERSION)",
        "NSExtension": [
          "NSExtensionPointIdentifier": "com.apple.widgetkit-extension",
        ]
      ])
    }
  }
}
