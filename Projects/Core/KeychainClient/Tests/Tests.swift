//
//  Tests.swift
//  KeychainClientTests
//
//  Created by devMinseok on 7/20/24.
//  Copyright © 2024 PomoNyang. All rights reserved.
//

import XCTest

import KeychainClient
import KeychainClientTesting

import Dependencies

final class Tests: XCTestCase {
  @Dependency(\.keychainClient) var keychainClient
  
  override func setUp() {
    withDependencies {
      $0.keychainClient = .mock
    } operation: {
    }
    super.setUp()
  }
  
  override func setUpWithError() throws {}
  
  override func tearDownWithError() throws {}
  
  func testExample() throws {
    // given
    let testKey = "TestKey"
    let testValue = "TestValue"
    
    // when
    let result = keychainClient.create(key: testKey, data: testValue)
    
    // then
    XCTAssertEqual(result, true)
  }
}
