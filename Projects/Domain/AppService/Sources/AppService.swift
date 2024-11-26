//
//  AppService.swift
//  AppService
//
//  Created by devMinseok on 8/4/24.
//  Copyright © 2024 PomoNyang. All rights reserved.
//

import Logger
import DatabaseClientInterface
import UserDefaultsClientInterface

import RealmSwift

let currentSchemaVersion: UInt64 = 1

public func initilizeDatabaseSystem(
  databaseClient: DatabaseClient
) async throws -> Void {
  // DB 마이그레이션 정의
  let configuration = Realm.Configuration(
    schemaVersion: currentSchemaVersion
  ) { migration, oldSchemaVersion in
    Logger.shared.log(
      category: .database,
      "[Realm DB Migration] oldVersion: \(oldSchemaVersion) -> newVersion: \(currentSchemaVersion)"
    )
    
    Logger.shared.log(category: .database, "[Realm DB Migration] Complete")
  }
  
  Logger.shared.log(category: .database, "💾 Realm Path :\n\(configuration.fileURL?.absoluteString ?? "NONE")")
  
  try await databaseClient.initialize(configuration)
}


let isDisturbAlarmOnKey = "mohanyang_userdefaults_isDisturmAlarmOnKey"

public func setDisturbAlarm(
  userDefaultsClient: UserDefaultsClient,
  isEnabled: Bool
) async -> Void {
  await userDefaultsClient.setBool(isEnabled, isDisturbAlarmOnKey)
}

public func getDisturbAlarm(
  userDefaultsClient: UserDefaultsClient
) -> Bool {
  return userDefaultsClient.boolForKey(isDisturbAlarmOnKey)
}


let isTimerAlarmOnKey = "mohanyang_userdefaults_isTimerAlarmOnKey"

public func setTimerAlarm(
  userDefaultsClient: UserDefaultsClient,
  isEnabled: Bool
) async -> Void {
  await userDefaultsClient.setBool(isEnabled, isTimerAlarmOnKey)
}

public func getTimerAlarm(
  userDefaultsClient: UserDefaultsClient
) -> Bool {
  return userDefaultsClient.boolForKey(isTimerAlarmOnKey)
}


let isLiveActivityOnKey = "mohanyang_userdefaults_isLiveActivityOnKey"

public func setLiveActivityState(
  userDefaultsClient: UserDefaultsClient,
  isEnabled: Bool
) async -> Void {
  await userDefaultsClient.setBool(isEnabled, isLiveActivityOnKey)
}

public func getLiveActivityState(
  userDefaultsClient: UserDefaultsClient
) -> Bool {
  return userDefaultsClient.boolForKey(isLiveActivityOnKey)
}
