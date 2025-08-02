//
//  FocusTimeHistory.swift
//  PomodoroServiceInterface
//
//  Created by devMinseok on 8/20/24.
//  Copyright © 2024 PomoNyang. All rights reserved.
//

import Foundation

import DatabaseClientInterface

import RealmSwift

public struct FocusTimeHistory: Encodable, Persistable {
  let clientFocusTimeId: String
  let categoryNo: Int
  let focusedTime: String
  let restedTime: String
  let startedAt: Date
  let doneAt: Date
  
  public init(
    clientFocusTimeId: String = UUID().uuidString,
    categoryNo: Int,
    focusedTime: String,
    restedTime: String,
    startedAt: Date,
    doneAt: Date
  ) {
    self.clientFocusTimeId = clientFocusTimeId
    self.categoryNo = categoryNo
    self.focusedTime = focusedTime
    self.restedTime = restedTime
    self.startedAt = startedAt
    self.doneAt = doneAt
  }
  
  @_spi(Internal)
  public init(managedObject: FocusTimeHistoryObject) {
    self.clientFocusTimeId = managedObject.clientFocusTimeId
    self.categoryNo = managedObject.categoryNo
    self.focusedTime = managedObject.focusedTime
    self.restedTime = managedObject.restedTime
    self.startedAt = managedObject.doneAt
    self.doneAt = managedObject.doneAt
  }
  
  @_spi(Internal)
  public func managedObject() -> FocusTimeHistoryObject {
    let object = FocusTimeHistoryObject()
    object.clientFocusTimeId = clientFocusTimeId
    object.categoryNo = categoryNo
    object.focusedTime = focusedTime
    object.restedTime = restedTime
    object.startedAt = startedAt
    object.doneAt = doneAt
    return object
  }
}


@_spi(Internal)
public final class FocusTimeHistoryObject: Object {
  @Persisted(primaryKey: true) var clientFocusTimeId: String
  @Persisted var categoryNo: Int
  @Persisted var focusedTime: String
  @Persisted var restedTime: String
  @Persisted var startedAt: Date
  @Persisted var doneAt: Date
}
