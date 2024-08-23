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
      tracking: false,
      trackingDomains: [],
      collectedDataTypes: [
        [
          "NSPrivacyCollectedDataType": "NSPrivacyCollectedDataTypeDeviceID",
          "NSPrivacyCollectedDataTypeLinked": false,
          "NSPrivacyCollectedDataTypeTracking": true,
          "NSPrivacyCollectedDataTypePurposes": ["NSPrivacyCollectedDataTypePurposeAppFunctionality"]
        ],
        [
          "NSPrivacyCollectedDataType": "NSPrivacyCollectedDataTypeCrashData",
          "NSPrivacyCollectedDataTypeLinked": false,
          "NSPrivacyCollectedDataTypeTracking": false,
          "NSPrivacyCollectedDataTypePurposes": [
            "NSPrivacyCollectedDataTypePurposeAnalytics",
            "NSPrivacyCollectedDataTypePurposeAppFunctionality"
          ]
        ],
        [
          "NSPrivacyCollectedDataType": "NSPrivacyCollectedDataTypePerformanceData",
          "NSPrivacyCollectedDataTypeLinked": false,
          "NSPrivacyCollectedDataTypeTracking": false,
          "NSPrivacyCollectedDataTypePurposes": ["NSPrivacyCollectedDataTypePurposeAppFunctionality"]
        ],
        [
          "NSPrivacyCollectedDataType": "NSPrivacyCollectedDataTypeOtherDiagnosticData",
          "NSPrivacyCollectedDataTypeLinked": false,
          "NSPrivacyCollectedDataTypeTracking": false,
          "NSPrivacyCollectedDataTypePurposes": ["NSPrivacyCollectedDataTypePurposeAppFunctionality"]
        ],
        [
          "NSPrivacyCollectedDataType": "NSPrivacyCollectedDataTypeProductInteraction",
          "NSPrivacyCollectedDataTypeLinked": false,
          "NSPrivacyCollectedDataTypeTracking": false,
          "NSPrivacyCollectedDataTypePurposes": ["NSPrivacyCollectedDataTypePurposeAppFunctionality"]
        ],
        [
          "NSPrivacyCollectedDataType": "NSPrivacyCollectedDataTypeOtherUsageData",
          "NSPrivacyCollectedDataTypeLinked": false,
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
