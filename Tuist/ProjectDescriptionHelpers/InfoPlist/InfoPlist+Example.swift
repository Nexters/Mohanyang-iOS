//
//  InfoPlist+Example.swift
//  ProjectDescriptionHelpers
//
//  Created by MinseokKang on 2024/07/15.
//

import ProjectDescription

extension InfoPlist {
  public enum Example {
    public static func app(name: String) -> InfoPlist {
      return .dictionary([
        // MARK: - Core Foundation
        
        "CFBundleDevelopmentRegion": "ko_KR",
        "CFBundleDisplayName": "\(name)",
        "CFBundleExecutable": "$(EXECUTABLE_NAME)",
        "CFBundleIdentifier": "$(PRODUCT_BUNDLE_IDENTIFIER)",
        "CFBundleInfoDictionaryVersion": "6.0",
        "CFBundleName": "\(name)",
        "CFBundlePackageType": "APPL",
        "CFBundleShortVersionString": "1.0.0",
        "CFBundleVersion": "1",
        
        
        // MARK: - Launch Services
        
        "LSRequiresIPhoneOS": true,
        
        
        // MARK: - Live Activities
        
        "NSSupportsLiveActivities": true,
        
        
        // MARK: - Cocoa
        
        "NSAppTransportSecurity": [
          "NSAllowsArbitraryLoads": true
        ],
        "NSBonjourServices": [
          "_dartobservatory._tcp"
        ],
        "NSCameraUsageDescription": "앱이 디바이스의 카메라에 액세스할 수 있는 이유를 지정합니다.",
        "NSContactsUsageDescription": "앱이 사용자의 연락처에 액세스하는 이유를 지정합니다.",
        "NSLocationWhenInUseUsageDescription": "앱이 사용 중인 동안 앱이 사용자의 위치 정보에 액세스할 수 있는 이유를 지정합니다.",
        "NSPhotoLibraryUsageDescription": "앱이 사용자의 사진 라이브러리에 액세스할 수 있는 이유를 지정합니다.",
        "NSUserTrackingUsageDescription": "앱이 사용자 또는 디바이스 추적을 위해 데이터 사용 권한을 요청하는 이유를 지정합니다.",
        "NSMicrophoneUsageDescription": "앱이 기기의 마이크에 액세스할 수 있는 이유를 지정합니다.",
        
        
        // MARK: - UIKit
        
        "UILaunchStoryboardName": "LaunchScreen",
        "UIAppFonts": [
          "Pretendard-Bold.otf",
          "Pretendard-Medium.otf",
          "Pretendard-Regular.otf",
          "Pretendard-SemiBold.otf"
        ]
      ])
    }
  }
}
