//
//  PrivacyManifest
//  ProjectDescriptionHelpers
//
//  Created by MinseokKang on 2024/07/15.
//

import ProjectDescription

extension PrivacyManifest {
  public static var mohanyang: Self {
    return .privacyManifest(
      tracking: true,
      trackingDomains: [],
      collectedDataTypes: [
        [
          "NSPrivacyCollectedDataType": "NSPrivacyCollectedDataTypeCrashData",
          "NSPrivacyCollectedDataTypeLinked": false,
          "NSPrivacyCollectedDataTypeTracking": false,
          "NSPrivacyCollectedDataTypePurposes": ["NSPrivacyCollectedDataTypePurposeAnalytics"]
        ],
        [
          "NSPrivacyCollectedDataType": "NSPrivacyCollectedDataTypeProductInteraction",
          "NSPrivacyCollectedDataTypeLinked": false,
          "NSPrivacyCollectedDataTypeTracking": false,
          "NSPrivacyCollectedDataTypePurposes": ["NSPrivacyCollectedDataTypePurposeAnalytics"]
        ],
        [
          "NSPrivacyCollectedDataType": "NSPrivacyCollectedDataTypeDeviceID",
          "NSPrivacyCollectedDataTypeLinked": false,
          "NSPrivacyCollectedDataTypeTracking": true,
          "NSPrivacyCollectedDataTypePurposes": ["NSPrivacyCollectedDataTypePurposeDeveloperAdvertising"]
        ],
        [
          "NSPrivacyCollectedDataType": "NSPrivacyCollectedDataTypeSearchHistory",
          "NSPrivacyCollectedDataTypeLinked": false,
          "NSPrivacyCollectedDataTypeTracking": false,
          "NSPrivacyCollectedDataTypePurposes": ["NSPrivacyCollectedDataTypePurposeProductPersonalization"]
        ],
        [
          "NSPrivacyCollectedDataType": "NSPrivacyCollectedDataTypePhotosorVideos",
          "NSPrivacyCollectedDataTypeLinked": false,
          "NSPrivacyCollectedDataTypeTracking": false,
          "NSPrivacyCollectedDataTypePurposes": ["NSPrivacyCollectedDataTypePurposeAppFunctionality"]
        ],
        [
          "NSPrivacyCollectedDataType": "NSPrivacyCollectedDataTypeContacts",
          "NSPrivacyCollectedDataTypeLinked": false,
          "NSPrivacyCollectedDataTypeTracking": false,
          "NSPrivacyCollectedDataTypePurposes": ["NSPrivacyCollectedDataTypePurposeAppFunctionality"]
        ],
        [
          "NSPrivacyCollectedDataType": "NSPrivacyCollectedDataTypeCoarseLocation",
          "NSPrivacyCollectedDataTypeLinked": false,
          "NSPrivacyCollectedDataTypeTracking": false,
          "NSPrivacyCollectedDataTypePurposes": ["NSPrivacyCollectedDataTypePurposeProductPersonalization"]
        ],
        [
          "NSPrivacyCollectedDataType": "NSPrivacyCollectedDataTypePaymentInfo",
          "NSPrivacyCollectedDataTypeLinked": false,
          "NSPrivacyCollectedDataTypeTracking": false,
          "NSPrivacyCollectedDataTypePurposes": ["NSPrivacyCollectedDataTypePurposeAppFunctionality"]
        ],
        [
          "NSPrivacyCollectedDataType": "NSPrivacyCollectedDataTypePhoneNumber",
          "NSPrivacyCollectedDataTypeLinked": true,
          "NSPrivacyCollectedDataTypeTracking": false,
          "NSPrivacyCollectedDataTypePurposes": ["NSPrivacyCollectedDataTypePurposeAppFunctionality"]
        ],
        [
          "NSPrivacyCollectedDataType": "NSPrivacyCollectedDataTypeEmailAddress",
          "NSPrivacyCollectedDataTypeLinked": true,
          "NSPrivacyCollectedDataTypeTracking": false,
          "NSPrivacyCollectedDataTypePurposes": ["NSPrivacyCollectedDataTypePurposeAppFunctionality"]
        ],
        [
          "NSPrivacyCollectedDataType": "NSPrivacyCollectedDataTypeName",
          "NSPrivacyCollectedDataTypeLinked": true,
          "NSPrivacyCollectedDataTypeTracking": false,
          "NSPrivacyCollectedDataTypePurposes": ["NSPrivacyCollectedDataTypePurposeAppFunctionality"]
        ]
      ],
      accessedApiTypes: [
        [
          "NSPrivacyAccessedAPITypeReasons": ["CA92.1"],
          "NSPrivacyAccessedAPIType": "NSPrivacyAccessedAPICategoryUserDefaults"
        ]
      ]
    )
  }
}
