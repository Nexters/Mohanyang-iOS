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
        // MARK: - ThirdParty
        
        "KAKAO_APP_KEY": "",
        
        
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
        
        
        // MARK: - Cocoa
        
        "NSAppTransportSecurity": [
          "NSAllowsArbitraryLoads": true
        ],
        "NSBonjourServices": [
          "_dartobservatory._tcp"
        ],
        "NSCameraUsageDescription": "",
        "NSContactsUsageDescription": "",
        "NSLocationWhenInUseUsageDescription": "",
        "NSMicrophoneUsageDescription": "",
        "NSPhotoLibraryUsageDescription": "",
        "NSUserTrackingUsageDescription": "",
        
        
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
  }
}
