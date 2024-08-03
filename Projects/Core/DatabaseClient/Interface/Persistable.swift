//
//  Persistable.swift
//  DatabaseClientInterface
//
//  Created by devMinseok on 8/3/24.
//  Copyright © 2024 PomoNyang. All rights reserved.
//

import Foundation

import RealmSwift

public protocol Persistable where Self: Decodable {
  associatedtype ManagedObject: Object
  
  var id: UUID { get set }
  init(managedObject: ManagedObject)
  func managedObject() -> ManagedObject
}
