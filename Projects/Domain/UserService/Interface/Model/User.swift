//
//  User.swift
//  UserServiceInterface
//
//  Created by devMinseok on 8/22/24.
//  Copyright © 2024 PomoNyang. All rights reserved.
//

@_spi(Internal)
import CatServiceInterface
import DatabaseClientInterface

import RealmSwift

public struct User: Persistable, Equatable, Codable {
  public var registeredDeviceNo: Int
  public var isPushEnabled: Bool
  public var cat: Cat?
  
  @_spi(Internal)
  public init(managedObject: UserObject) {
    self.registeredDeviceNo = managedObject.registeredDeviceNo
    self.isPushEnabled = managedObject.isPushEnabled
    if let catObject = managedObject.cat {
      self.cat = Cat(managedObject: catObject)
    }
  }
  
  @_spi(Internal)
  public func managedObject() -> UserObject {
    let object = UserObject()
    object.registeredDeviceNo = registeredDeviceNo
    object.isPushEnabled = isPushEnabled
    object.cat = cat?.managedObject()
    return object
  }
}

@_spi(Internal)
public final class UserObject: Object {
  @Persisted(primaryKey: true) var registeredDeviceNo: Int
  @Persisted var isPushEnabled: Bool
  @Persisted var cat: CatObject?
}
