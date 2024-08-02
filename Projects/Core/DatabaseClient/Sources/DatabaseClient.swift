//
//  DatabaseClient.swift
//  DatabaseClient
//
//  Created by devMinseok on 7/27/24.
//

import Foundation

import DatabaseClientInterface

import RealmSwift
import Dependencies

extension DatabaseClient: DependencyKey {
  public static let liveValue: DatabaseClient = .live()
  
  private static func live() -> DatabaseClient {
    return .init(
      initialize: {
        if realmActor == nil {
          realmActor = try await RealmActor()
        } else {
          throw(NSError(domain: "Realm already initialized", code: 0))
        }
      },
      create: { object in
        if let realmActor {
          let threadSafeReference = ThreadSafeReference(to: object.managedObject())
          try await realmActor.create(threadSafeReference)
        } else {
          throw(NSError(domain: "Realm is not initialized", code: 0))
        }
      },
      read: { type, isIncluded in
        if let realmActor {
          let results = realmActor.read(type.ManagedObject)
          if let isIncluded {
            return results.where(isIncluded).compactMap { type(managedObject: $0) }
          } else {
            return results.compactMap { type(managedObject: $0) }
          }
        } else {
          throw(NSError(domain: "Realm is not initialized", code: 0))
        }
      },
      update: { object in
        if let realmActor {
          let threadSafeReference = ThreadSafeReference(to: object.managedObject())
          try await realmActor.update(threadSafeReference)
        } else {
          throw(NSError(domain: "Realm is not initialized", code: 0))
        }
      },
      updateWithValue: { object, value in
        if let realmActor {
          try await realmActor.update(object, value: value)
        } else {
          throw(NSError(domain: "Realm is not initialized", code: 0))
        }
      }
    )
  }
  
  
  // MARK: - Realm Actor
  
  static var realmActor: RealmActor?
  
  actor RealmActor {
    var realm: Realm!
    
    init() async throws {
      realm = try await Realm(actor: self)
    }
    
    func create<T: Object>(_ object: ThreadSafeReference<T>) async throws {
      try await realm.asyncWrite {
        if let resolved = realm.resolve(object) {
          realm.add(resolved, update: .error)
        } else {
          throw(NSError(domain: "ThreadSafeReference resolve failed", code: 0))
        }
      }
    }
    
    func read<T: Object>(_ object: T.Type) -> Results<T> {
      return realm.objects(T.self)
    }
    
    func update<T: Object>(_ object: ThreadSafeReference<T>) async throws {
      try await realm.asyncWrite {
        if let resolved = realm.resolve(object) {
          realm.add(resolved, update: .modified)
        } else {
          throw(NSError(domain: "ThreadSafeReference resolve failed", code: 0))
        }
      }
    }
    
    func update<T: Object>(_ object: T.Type, value: Any) async throws {
      try await realm.asyncWrite {
        realm.create(
          object,
          value: value,
          update: .modified
        )
      }
    }
    
    func delete<T: Object>(_ object: T) async throws {
      try await realm.asyncWrite {
        realm.delete(object)
      }
    }
  }
}
