//
//  UserDefaultsClient.swift
//  UserDefaultsClient
//
//  Created by devMinseok on 8/4/24.
//

import Foundation

import Dependencies

import UserDefaultsClientInterface

extension UserDefaultsClient: DependencyKey {
  public static let liveValue: UserDefaultsClient = .live()
  
  public static func live() -> UserDefaultsClient {
    let userDefaults = { UserDefaults.standard }
    return .init(
      setString: { userDefaults().set($0, forKey: $1) },
      setBool: { userDefaults().set($0, forKey: $1) },
      setData: { userDefaults().set($0, forKey: $1) },
      setDouble: { userDefaults().set($0, forKey: $1) },
      setInteger: { userDefaults().set($0, forKey: $1) },
      stringForKey: { userDefaults().string(forKey: $0) },
      boolForKey: { userDefaults().bool(forKey: $0) },
      dataForKey: { userDefaults().data(forKey: $0) },
      doubleForKey: { userDefaults().double(forKey: $0) },
      integerForKey: { userDefaults().integer(forKey: $0) },
      remove: { userDefaults().removeObject(forKey: $0) },
      removePersistentDomain: { userDefaults().removePersistentDomain(forName: $0) }
    )
  }
}
