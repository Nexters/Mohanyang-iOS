//
//  Entitlements
//  ProjectDescriptionHelpers
//
//  Created by MinseokKang on 2024/07/15.
//

import ProjectDescription

extension Entitlements {
  public enum Mohanyang {
    public static var app: Entitlements {
      return .dictionary([
        "aps-environment": "development",
        "com.apple.developer.applesignin": ["Default"],
        "com.apple.developer.associated-domains": []
      ])
    }
    
    public static var widgetExtension: Entitlements {
      return .dictionary([:])
    }
  }
}
