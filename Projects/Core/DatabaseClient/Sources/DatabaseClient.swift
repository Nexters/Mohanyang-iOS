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
  
  public static func live() -> DatabaseClient {
    return .init(
      initialize: { configuration in
        if realmActor == nil {
          realmActor = try await RealmActor(configuration: configuration)
        }
      },
      create: { object in
        if let realmActor {
          try await realmActor.create(object.managedObject())
        } else {
          throw(NSError(domain: "Realm is not initialized", code: 0))
        }
      },
      read: { type in
        if let realmActor {
          let results = await realmActor.read(type as! Object.Type)
          return results
        } else {
          throw(NSError(domain: "Realm is not initialized", code: 0))
        }
      },
      readWithFilter: { type, predicateFormat, args in
        if let realmActor {
          let results = await realmActor.read(type, predicateFormat: predicateFormat, args: args)
          return results
        } else {
          throw(NSError(domain: "Realm is not initialized", code: 0))
        }
      },
      update: { object in
        if let realmActor {
          try await realmActor.update(object.managedObject())
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
      },
      delete: { object in
        if let realmActor {
          try await realmActor.delete(object)
        } else {
          throw(NSError(domain: "Realm is not initialized", code: 0))
        }
      },
      deleteTable: { objectType in
        if let realmActor {
          try await realmActor.delete(objectType)
        } else {
          throw(NSError(domain: "Realm is not initialized", code: 0))
        }
      },
      deleteAllTable: {
        if let realmActor {
          try await realmActor.deleteAll()
        } else {
          throw(NSError(domain: "Realm is not initialized", code: 0))
        }
      },
      checkHasTable: {
        if let realmActor {
          await realmActor.checkHasTable()
        } else {
          throw(NSError(domain: "Realm is not initialized", code: 0))
        }
      }
    )
  }
}

extension DatabaseClient.RealmActor {
  public func create<T: Object>(_ object: T) async throws {
    try await realm.asyncWrite {
      realm.add(object, update: .modified)
    }
  }
  
  public func read<T: Object>(_ object: T.Type) -> [T] {
    let results = realm.objects(object)
    return results.map { $0 }
  }
  
  public func read<T: Object>(_ object: T.Type, predicateFormat: String, args: Any...) -> [T] {
    let results = realm.objects(object)
    return results.filter(predicateFormat, args).map { $0 }
  }
  
  public func update<T: Object>(_ object: T) async throws {
    try await realm.asyncWrite {
      realm.add(object, update: .modified)
    }
  }
  
  public func update<T: Object>(_ object: T.Type, value: Any) async throws {
    try await realm.asyncWrite {
      realm.create(
        object,
        value: value,
        update: .modified
      )
    }
  }
  
  public func delete<T: Object>(_ object: T) async throws {
    try await realm.asyncWrite {
      realm.delete(object)
    }
  }
  
  public func delete<T: Object>(_ object: T.Type) async throws {
    let objects = realm.objects(object)
    try await realm.asyncWrite {
      realm.delete(objects)
    }
  }
  
  public func deleteAll() async throws {
    try await realm.asyncWrite {
      realm.deleteAll()
    }
  }
  
  public func checkHasTable() -> Bool{
    return !realm.isEmpty
  }
}
