//
//  PomodoroCategory.swift
//  PomodoroServiceInterface
//
//  Created by devMinseok on 8/17/24.
//  Copyright © 2024 PomoNyang. All rights reserved.
//

import SwiftUI
import Foundation

import Utils
import DesignSystem
import DatabaseClientInterface

import RealmSwift

public struct PomodoroCategory:
  Persistable,
  Equatable,
  Identifiable,
  Codable,
  Hashable {
  
  public var id: Int {
    return no
  }
  public let no: Int
  public let baseCategoryCode: PomodoroCategoryCode
  public let title: String
  public let position: Int
  public var focusTime: String
  public var restTime: String
  
  @_spi(Internal)
  public init(managedObject: PomodoroCategoryObject) {
    self.no = managedObject.no
    self.baseCategoryCode = managedObject.baseCategoryCode
    self.title = managedObject.title
    self.position = managedObject.position
    self.focusTime = managedObject.focusTime
    self.restTime = managedObject.restTime
  }
  
  @_spi(Internal)
  public func managedObject() -> PomodoroCategoryObject {
    let object = PomodoroCategoryObject()
    object.no = no
    object.baseCategoryCode = baseCategoryCode
    object.title = title
    object.position = position
    object.focusTime = focusTime
    object.restTime = restTime
    return object
  }
  
  /// 추후 서버에서 내려받는걸로 개선
  public var image: Image {
    switch baseCategoryCode {
    case .basic:
      return DesignSystemAsset.Image._24Cat.swiftUIImage
    case .books:
      return DesignSystemAsset.Image._24Book.swiftUIImage
    case .study:
      return DesignSystemAsset.Image._24Memo.swiftUIImage
    case .work:
      return DesignSystemAsset.Image._24Monitor.swiftUIImage
    }
  }
}

extension PomodoroCategory {
  public var focusTimeMinutes: Int {
    let dateComponents = DateComponents.durationFrom8601String(focusTime)
    return dateComponents?.totalMinutes ?? 0
  }
  
  public var restTimeMinutes: Int {
    let dateComponents = DateComponents.durationFrom8601String(restTime)
    return dateComponents?.totalMinutes ?? 0
  }
  
  public var focusTimeSeconds: Int {
    let dateComponents = DateComponents.durationFrom8601String(focusTime)
    return dateComponents?.totalSeconds ?? 0
  }
  
  public var restTimeSeconds: Int {
    let dateComponents = DateComponents.durationFrom8601String(restTime)
    return dateComponents?.totalSeconds ?? 0
  }
}

public enum PomodoroCategoryCode: String, PersistableEnum, Codable {
  case basic = "BASIC"
  case books = "BOOKS"
  case study = "STUDY"
  case work = "WORK"
}

@_spi(Internal)
public final class PomodoroCategoryObject: Object {
  @Persisted(primaryKey: true) var no: Int
  @Persisted var baseCategoryCode: PomodoroCategoryCode
  @Persisted var title: String
  @Persisted var position: Int
  @Persisted var focusTime: String
  @Persisted var restTime: String
}
