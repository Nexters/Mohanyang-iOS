//
//  Cat.swift
//  CatServiceInterface
//
//  Created by devMinseok on 8/22/24.
//  Copyright © 2024 PomoNyang. All rights reserved.
//

import RealmSwift

import DatabaseClientInterface

public struct Cat: Persistable, Equatable, Codable {
  public var no: Int
  public var name: String
  public var type: CatType
  
  public init(no: Int, name: String, type: CatType) {
    self.no = no
    self.name = name
    self.type = type
  }
  
  @_spi(Internal)
  public init(managedObject: CatObject) {
    self.no = managedObject.no
    self.name = managedObject.name
    self.type = managedObject.type
  }
  
  @_spi(Internal)
  public func managedObject() -> CatObject {
    let object = CatObject()
    object.no = no
    object.name = name
    object.type = type
    return object
  }
}

@_spi(Internal)
public final class CatObject: Object {
  @Persisted(primaryKey: true) var no: Int
  @Persisted var name: String
  @Persisted var type: CatType
}

public enum CatType: String, Codable, PersistableEnum {
  case cheese = "CHEESE"
  case black = "BLACK"
  case threeColor = "THREE_COLOR"
}
