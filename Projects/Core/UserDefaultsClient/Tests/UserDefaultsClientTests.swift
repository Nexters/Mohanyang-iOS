//
//  UserDefaultsClientTests.swift
//  UserDefaultsClient
//
//  Created by devMinseok on 8/4/24.
//

import XCTest

import UserDefaultsClient
import UserDefaultsClientInterface

import Dependencies

final class UserDefaultsClientTests: XCTestCase {
  @Dependency(UserDefaultsClient.self) var userDefaultsClient
  
  override func tearDown() {
    withDependencies {
      $0[UserDefaultsClient.self] = UserDefaultsClient.live()
    } operation: {
      userDefaultsClient.removePersistentDomain(bundleId: Bundle.main.bundleIdentifier ?? "")
    }
    super.tearDown()
  }
  
  func testSetString() async {
    await withDependencies {
      $0[UserDefaultsClient.self] = UserDefaultsClient.live()
    } operation: {
      // given
      let testKey: String = "TestKey"
      let testValue: String = "TestString"
      
      // when
      await userDefaultsClient.setString(testValue, key: testKey)
      
      // then
      let result = userDefaultsClient.stringForKey(testKey)
      XCTAssertEqual(result, testValue)
    }
  }
  
  func testSetBool() async {
    await withDependencies {
      $0[UserDefaultsClient.self] = UserDefaultsClient.live()
    } operation: {
      // given
      let testKey: String = "TestKeyBool"
      let testValue: Bool = true
      
      // when
      await userDefaultsClient.setBool(testValue, testKey)
      
      // then
      let result = userDefaultsClient.boolForKey(testKey)
      XCTAssertEqual(result, testValue)
    }
  }
  
  func testSetData() async {
    await withDependencies {
      $0[UserDefaultsClient.self] = UserDefaultsClient.live()
    } operation: {
      // given
      let testKey: String = "TestKeyData"
      let testValue: Data = "TestData".data(using: .utf8)!
      
      // when
      await userDefaultsClient.setData(testValue, testKey)
      
      // then
      let result = userDefaultsClient.dataForKey(testKey)
      XCTAssertEqual(result, testValue)
    }
  }
  
  func testSetDouble() async {
    await withDependencies {
      $0[UserDefaultsClient.self] = UserDefaultsClient.live()
    } operation: {
      // given
      let testKey: String = "TestKeyDouble"
      let testValue: Double = 123.456
      
      // when
      await userDefaultsClient.setDouble(testValue, testKey)
      
      // then
      let result = userDefaultsClient.doubleForKey(testKey)
      XCTAssertEqual(result, testValue)
    }
  }
  
  func testSetInteger() async {
    await withDependencies {
      $0[UserDefaultsClient.self] = UserDefaultsClient.live()
    } operation: {
      // given
      let testKey: String = "TestKeyInteger"
      let testValue: Int = 123
      
      // when
      await userDefaultsClient.setInteger(testValue, testKey)
      
      // then
      let result = userDefaultsClient.integerForKey(testKey)
      XCTAssertEqual(result, testValue)
    }
  }
  
  func testRemove() async {
    await withDependencies {
      $0[UserDefaultsClient.self] = UserDefaultsClient.live()
    } operation: {
      // given
      let testKey: String = "TestKeyRemove"
      let testValue: String = "TestString"
      await userDefaultsClient.setString(testValue, testKey)
      
      // when
      await userDefaultsClient.remove(testKey)
      
      // then
      let result = userDefaultsClient.stringForKey(testKey)
      XCTAssertNil(result)
    }
  }
}
