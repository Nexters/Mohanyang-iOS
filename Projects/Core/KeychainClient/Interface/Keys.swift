//
//  Keys.swift
//  KeychainClientInterface
//
//  Created by 김지현 on 8/9/24.
//  Copyright © 2024 PomoNyang. All rights reserved.
//

import Foundation

public enum KeychainKeys: String {
  case accessToken = "mohanyang_keychain_access_token"
  case refreshToken = "mohanyang_keychain_refresh_token"
  case deviceID = "mohanyang_keychain_deviceID"
}
