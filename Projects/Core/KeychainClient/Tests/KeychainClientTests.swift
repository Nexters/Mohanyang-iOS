//
//  KeychainClientTests.swift
//  KeychainClientTests
//
//  Created by devMinseok on 7/20/24.
//  Copyright © 2024 PomoNyang. All rights reserved.
//

import XCTest

import KeychainClient
import KeychainClientInterface
import KeychainClientTesting

import Dependencies

final class Tests: XCTestCase {
  @Dependency(KeychainClient.self) var keychainClient
  
  override func setUp() {
    super.setUp()
  }
  
  override func tearDown() {
    withDependencies {
      $0[KeychainClient.self] = KeychainClient.live()
    } operation: {
      keychainClient.deleteAll()
    }
    super.tearDown()
  }
  
  override func setUpWithError() throws {}
  
  override func tearDownWithError() throws {}
  
  func testCRUD() throws {
    withDependencies {
      $0[KeychainClient.self] = KeychainClient.live()
    } operation: {
      // create
      let testKey = "TestKey"
      let initialValue = "TestValue"
      let isSuccessCreate = keychainClient.create(key: testKey, data: initialValue)
      XCTAssertEqual(isSuccessCreate, true)
      
      // read
      let result1 = keychainClient.read(key: testKey)
      XCTAssertEqual(result1, initialValue)
      
      // update
      let updateValue = "UpdateValue"
      let isSuccessUpdate = keychainClient.update(key: testKey, data: updateValue)
      let result2 = keychainClient.read(key: testKey)
      XCTAssertEqual(isSuccessUpdate, true)
      XCTAssertEqual(result2, updateValue)
      
      // delete
      let isSuccessDelete = keychainClient.delete(key: testKey)
      let result3 = keychainClient.read(key: testKey)
      XCTAssertEqual(isSuccessDelete, true)
      XCTAssertEqual(result3, nil)
    }
  }
}
