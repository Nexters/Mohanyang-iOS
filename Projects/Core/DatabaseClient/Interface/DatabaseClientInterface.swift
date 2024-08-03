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
  public var initialize: @Sendable (Realm.Configuration) async throws -> Void
  public var create: @Sendable (any Persistable) async throws -> Void
  public var read: @Sendable (Object.Type, (((Query<Results<Object>.Element>) -> Query<Bool>)?)) async throws -> [Object]
  public var update: @Sendable (any Persistable) async throws -> Void
  public var updateWithValue: @Sendable (Object.Type, Any) async throws -> Void
  
  public func create<T: Persistable>(object: T) async throws -> Void {
    try await create(object)
  }
  
  public func read<T: Persistable>(_ type: T.Type, where isIncluded: ((Query<Results<T.ManagedObject>.Element>) -> Query<Bool>)?) async throws -> [T] {
    let result = try await self.read(type.ManagedObject, (isIncluded as! (Query<Results<Object>.Element>) -> Query<Bool>))
    return result.compactMap { T(managedObject: $0 as! T.ManagedObject) }
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

extension DatabaseClient: TestDependencyKey {
  public static let previewValue = Self()
  public static let testValue = Self()
}
