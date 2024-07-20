//
//  LiveKey.swift
//  KeychainClient
//
//  Created by devMinseok on 7/20/24.
//  Copyright © 2024 PomoNyang. All rights reserved.
//

import Security
import Foundation

import KeychainClientInterface

import Dependencies

extension KeychainClient: DependencyKey {
  public static let liveValue: KeychainClient = .live()
  
  private static func live() -> KeychainClient {
    return KeychainClient(
      create: { key, data in
        if let data = data.data(using: .utf8) {
          let query = generateCreateQuery(key: key, data: data)
          return SecItemAdd(query, nil) == errSecSuccess
        } else {
          return false
        }
      },
      read: { key in
        let query = generateReadQuery(key: key)
        var item: CFTypeRef?
        if SecItemCopyMatching(query, &item) == errSecSuccess,
           let existingItem = item as? [CFString: Any],
           let data = existingItem[kSecValueData] as? Data {
          return String(data: data, encoding: .utf8)
        } else {
          return nil
        }
      },
      update: { key, data in
        if let data = data.data(using: .utf8) {
          let query = generateUpdateQuery(key: key)
          let updateAttributes: [CFString: Any] = [kSecValueData: data]
          return SecItemUpdate(query, updateAttributes as CFDictionary) == errSecSuccess
        } else {
          return false
        }
      },
      delete: { key in
        let query = generateDeleteQuery(key: key)
        return SecItemDelete(query) == errSecSuccess
      },
      deleteAll: {
        let kSecClassItems: [CFString] = [
          kSecClassInternetPassword,
          kSecClassGenericPassword,
          kSecClassCertificate,
          kSecClassKey,
          kSecClassIdentity
        ]
        for item in kSecClassItems {
          let query: [CFString: Any] = [kSecClass: item]
          SecItemDelete(query as CFDictionary)
        }
      }
    )
  }
  
  private static func generateCreateQuery(key: String, data: Data) -> CFDictionary {
    var baseQuery = generateBaseQuery(key: key)
    baseQuery[kSecValueData] = data
    return baseQuery as CFDictionary
  }
  
  private static func generateReadQuery(key: String) -> CFDictionary {
    var baseQuery = generateBaseQuery(key: key)
    baseQuery[kSecMatchLimit] = kSecMatchLimitOne
    baseQuery[kSecReturnAttributes] = true
    baseQuery[kSecReturnData] = true
    return baseQuery as CFDictionary
  }
  
  private static func generateUpdateQuery(key: String) -> CFDictionary {
    let baseQuery = generateBaseQuery(key: key)
    return baseQuery as CFDictionary
  }
  
  private static func generateDeleteQuery(key: String) -> CFDictionary {
    let baseQuery = generateBaseQuery(key: key)
    return baseQuery as CFDictionary
  }
  
  private static func generateBaseQuery(key: String) -> [CFString: Any] {
    var query: [CFString: Any] = [
      kSecClass: kSecClassGenericPassword,
      kSecAttrService: serviceId,
      kSecAttrAccount: key
    ]
    if let keychainAccessGroupId {
      query[kSecAttrAccessGroup] = keychainAccessGroupId
    }
    return query
  }
}

private let keychainAccessGroupId = Bundle.main.infoDictionary?["KeychainAccessGroupId"] as? String

/// 기본적으로 메인앱의 bundle id를 반환합니다.
/// app extension으로 실행될 경우를 고려하여 뒷 부분을 제거합니다
private var serviceId: String = {
  let currentMainBundleId = Bundle.main.bundleIdentifier ?? ""
  let applicationExtensionSuffixs = [
    ".shareextension",
    ".actionextension",
    ".photoeditingextension",
    ".documentproviderextension",
    ".fileproviderextension",
    ".customkeyboardextension",
    ".todayextension",
    ".intentsextension",
    ".intentsuiextension",
    ".notificationcontentextension",
    ".notificationserviceextension",
    ".safariwebextension",
    ".watchkitapp",
    ".watchkitappextension",
    ".stickerpackextension",
    ".imessageappextension"
  ]
  
  for suffix in applicationExtensionSuffixs {
    if currentMainBundleId.hasSuffix(suffix) {
      return String(currentMainBundleId.dropLast(suffix.count))
    }
  }
  
  return currentMainBundleId
}()
