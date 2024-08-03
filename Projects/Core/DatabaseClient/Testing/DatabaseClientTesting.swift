//
//  DatabaseClientTesting.swift
//  DatabaseClient
//
//  Created by devMinseok on 7/27/24.
//

import Foundation

import DatabaseClientInterface

import RealmSwift

public class TestObject: Object {
  @Persisted(primaryKey: true) public var id: UUID
  @Persisted public var test: Int
}

public struct Test: Persistable {
  public var id: UUID
  public var test: Int
  
  public init(
    id: UUID = UUID(),
    test: Int
  ) {
    self.id = id
    self.test = test
  }
  
  public init(managedObject: TestObject) {
    self.id = managedObject.id
    self.test = managedObject.test
  }
  
  public func managedObject() -> TestObject {
    let object = TestObject()
    object.id = id
    object.test = test
    return object
  }
}
