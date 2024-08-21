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
  /// Use create<T: Persistable>(object:).
  public var create: @Sendable (any Persistable) async throws -> Void
  /// Use read<T: Persistable>(_ type:).
  public var read: @Sendable (Object.Type) async throws -> [Object]
  /// Use read<T: Persistable>(_ type:, predicateFormat:, args:).
  public var readWithFilter: @Sendable (Object.Type, String, Any) async throws -> [Object]
  /// Use update<T: Persistable>(_ object:)
  public var update: @Sendable (any Persistable) async throws -> Void
  /// Use update<T: Object>(_ type:, value:).
  public var updateWithValue: @Sendable (Object.Type, Any) async throws -> Void
  /// Use delete<T: Object>(_ object:).
  public var delete: @Sendable (Object) async throws -> Void
  /// Use delete<T: Object>(_ object:).
  public var deleteTable: @Sendable (Object.Type) async throws -> Void
  /// Use delete<T: Object>(_ type:).
  public var deleteAllTable: @Sendable () async throws -> Void
  
  public var checkHasTable: @Sendable () async throws -> Bool
  
  public func create<T: Persistable>(object: T) async throws {
    try await create(object)
  }
  
  public func read<T: Persistable>(_ type: T.Type) async throws -> [T] {
    let results = try await self.read(type.ManagedObject)
    return await Self.realmActor?.convertToPersistable(type: type, objects: results) ?? []
  }
  
  public func read<T: Persistable>(_ type: T.Type, predicateFormat: String, args: Any) async throws -> [T] {
    let results = try await self.readWithFilter(type.ManagedObject, predicateFormat, args)
    return await Self.realmActor?.convertToPersistable(type: type, objects: results) ?? []
  }
  
  public func update<T: Persistable>(_ object: T) async throws {
    try await self.update(object)
  }
  
  public func update<T: Object>(_ type: T.Type, value: Any) async throws {
    try await self.updateWithValue(type, value)
  }
  
  public func delete<T: Object>(_ object: T) async throws {
    try await self.delete(object)
  }
  
  public func delete<T: Object>(_ type: T.Type) async throws {
    try await self.deleteTable(type)
  }
  
  
  // MARK: - Actor for realm
  
  public static var realmActor: RealmActor?
  
  public actor RealmActor {
    public var realm: Realm!
    
    public init(configuration: Realm.Configuration) async throws {
      realm = try await Realm(configuration: configuration, actor: self)
    }
    
    func convertToPersistable<T: Persistable>(type: T.Type, objects: [Object]) -> [T] {
      return objects.compactMap { type.init(managedObject: $0 as! T.ManagedObject) }
    }
  }
}


extension DatabaseClient: TestDependencyKey {
  public static let previewValue = Self()
  public static let testValue = Self()
}
