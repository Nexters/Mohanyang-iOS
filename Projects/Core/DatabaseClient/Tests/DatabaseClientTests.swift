
//  DatabaseClientTests.swift
//  DatabaseClient
//
//  Created by devMinseok on 7/27/24.
//

import XCTest

import DatabaseClient
import DatabaseClientInterface
import DatabaseClientTesting

import RealmSwift
import Dependencies

final class DatabaseClientTests: XCTestCase {
  @Dependency(DatabaseClient.self) var databaseClient
  
  override func setUp() async throws {
    try await withDependencies {
      $0[DatabaseClient.self] = DatabaseClient.live()
    } operation: {
      let inmemoryConfig = Realm.Configuration(inMemoryIdentifier: "DatabaseClientTests")
      try await databaseClient.initialize(inmemoryConfig)
    }
    try await super.setUp()
  }
  
  func testCRUD() async throws {
    try await withDependencies {
      $0[DatabaseClient.self] = DatabaseClient.live()
    } operation: {
      // create
      let initialNumber = 1
      var testModel = Test(test: initialNumber)
      try await databaseClient.create(object: testModel)
      
      // read
      let results1 = try await databaseClient.read(Test.self)
      XCTAssertEqual(results1[0].test, initialNumber)
      let updateNumber = 2
      testModel.test = 2
      
      // update
      try await databaseClient.update(testModel)
      let results2 = try await databaseClient.read(Test.self)
      XCTAssertEqual(results2[0].test, updateNumber)
      
      // delete
      try await databaseClient.deleteAllTable()
      let results3 = try await databaseClient.read(Test.self)
      XCTAssertEqual(results3.count, 0)
    }
  }
}
