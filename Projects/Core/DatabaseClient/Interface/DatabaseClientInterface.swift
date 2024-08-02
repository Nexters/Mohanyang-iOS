//
//  DatabaseClientInterface.swift
//  DatabaseClient
//
//  Created by devMinseok on 7/27/24.
//

import Foundation

import RealmSwift
import Dependencies
import DependenciesMacros

@DependencyClient
public struct DatabaseClient {
  public var initialize: @Sendable () async throws -> Void
  public var create: @Sendable (any Persistable) async throws -> Void
  public var read: @Sendable (any Persistable.Type, ((Query<Results<Object>.Element>) -> Query<Bool>)?) async throws -> [any Persistable]
  public var update: @Sendable (any Persistable) async throws -> Void
  public var updateWithValue: @Sendable (Object.Type, Any) async throws -> Void
  
  public func create<T: Persistable>(object: T) async throws -> Void {
    try await create(object)
  }
  
  public func read<T: Persistable>(_ type: T.Type, where isIncluded: ((Query<Results<T.ManagedObject>.Element>) -> Query<Bool>)?) async throws -> [T] {
    let result = try await self.read(type, isIncluded as? ((Query<Results<Object>.Element>) -> Query<Bool>))
    return result as! [T]
  }
  
  public func update<T: Persistable>(object: T) async throws {
    try await self.update(object)
  }
  
  public func update<T: Object>(object: T.Type, value: Any) async throws {
    try await self.updateWithValue(object, value)
  }
}

public protocol Persistable where Self: Decodable {
  associatedtype ManagedObject: Object
  
  init(managedObject: ManagedObject)
  func managedObject() -> ManagedObject
}

extension DependencyValues {
  public var databaseClient: DatabaseClient {
    get { self[DatabaseClient.self] }
    set { self[DatabaseClient.self] = newValue }
  }
}

extension DatabaseClient: TestDependencyKey {
  public static let previewValue = Self()
  public static let testValue = Self()
}
