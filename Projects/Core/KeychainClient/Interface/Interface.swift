//
//  Interface.swift
//  KeychainClient
//
//  Created by devMinseok on 7/20/24.
//  Copyright © 2024 PomoNyang. All rights reserved.
//

import Foundation

//import DependenciesMacros
import Dependencies

//@DependencyClient
public struct KeychainClient {
  public var create: @Sendable (String, String) -> Bool
  public var read: @Sendable (String) -> String?
  public var update: @Sendable (String, String) -> Bool
  public var delete: @Sendable (String) -> Bool
  public var deleteAll: @Sendable () -> Void
  
//  public func setAPIKey(_ apiKey: String) {
//    _ = create(apiKey_key, apiKey)
//  }
//  
//  public func getAPIKey() -> String? {
//    return read(apiKey_key)
//  }
//  
//  /// 앱 재설치시 이전 키체인 데이터를 제거
//  public func checkSubsequentRun() {
//    let isSubsequentRun: Bool = UserDefaults.standard.bool(forKey: isSubsequentRun_key)
//    if !isSubsequentRun {
//      deleteAll()
//      UserDefaults.standard.setValue(true, forKey: isSubsequentRun_key)
//    }
//  }
  
  public init(
    create: @Sendable @escaping (_: String, _: String) -> Bool,
    read: @Sendable @escaping (_: String) -> String?,
    update: @Sendable @escaping (_: String, _: String) -> Bool,
    delete: @Sendable @escaping (_: String) -> Bool,
    deleteAll: @Sendable  @escaping () -> Void
  ) {
    self.create = create
    self.read = read
    self.update = update
    self.delete = delete
    self.deleteAll = deleteAll
  }
}

let isSubsequentRun_key: String = "kimcaddie_userdefaults_key_isSubsequentRun"
let apiKey_key: String = "kimcaddie_keychain_key_apiKey"


// MARK: - DependencyValues

//extension DependencyValues {
//  public var keychainClient: KeychainClient {
//    get { self[KeychainClient.self] }
//    set { self[KeychainClient.self] = newValue }
//  }
//}
