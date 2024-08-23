//
//  KeychainClientInterface.swift
//  KeychainClient
//
//  Created by devMinseok on 7/20/24.
//  Copyright © 2024 PomoNyang. All rights reserved.
//

import Foundation

import Dependencies
import DependenciesMacros

@DependencyClient
public struct KeychainClient {
  public var create: @Sendable (_ key: String, _ data: String) -> Bool = { _, _ in true }
  
  public var read: @Sendable (_ key: String) -> String?
  
  public var update: @Sendable (_ key: String, _ data: String) -> Bool = { _, _ in true }
  
  public var delete: @Sendable (_ key: String) -> Bool = { _ in true }
  
  public var deleteAll: @Sendable () -> Void
  
  /// 앱 재설치시 이전 키체인 데이터를 제거
  public func checkSubsequentRun() {
    let isSubsequentRun: Bool = UserDefaults.standard.bool(forKey: isSubsequentRunKey)
    if !isSubsequentRun {
      deleteAll()
      UserDefaults.standard.setValue(true, forKey: isSubsequentRunKey)
    }
  }
}

let isSubsequentRunKey: String = "userdefaults_key_is_subsequent_run"

extension KeychainClient: TestDependencyKey {
  public static let previewValue = Self()
  public static let testValue = Self()
}
