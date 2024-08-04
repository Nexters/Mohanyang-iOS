//
//  UserDefaultsClientInterface.swift
//  UserDefaultsClient
//
//  Created by devMinseok on 8/4/24.
//

import Foundation

import Dependencies
import DependenciesMacros

@DependencyClient
public struct UserDefaultsClient {
  // MARK: - Create, Update
  
  public var setString: @Sendable (String?, _ key: String) async -> Void
  public var setBool: @Sendable (Bool, _ key: String) async -> Void
  public var setData: @Sendable (Data?, _ key: String) async -> Void
  public var setDouble: @Sendable (Double, _ key: String) async -> Void
  public var setInteger: @Sendable (Int, _ key: String) async -> Void
  
  // MARK: - Read
  
  public var stringForKey: @Sendable (String) -> String?
  public var boolForKey: @Sendable (String) -> Bool = { _ in false }
  public var dataForKey: @Sendable (String) -> Data?
  public var doubleForKey: @Sendable (String) -> Double = { _ in 0.0 }
  public var integerForKey: @Sendable (String) -> Int = { _ in 0 }
  
  
  // MARK: - Delete
  
  public var remove: @Sendable (String) async -> Void
  
  // MARK: - Reset
  
  public var removePersistentDomain: @Sendable (_ bundleId: String) -> Void
}

extension UserDefaultsClient: TestDependencyKey {
  public static var testValue = Self()
  public static var previewValue = Self()
}
