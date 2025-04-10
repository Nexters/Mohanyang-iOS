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
  public let iconType: PomodoroIconType
  public let title: String
  public let position: Int
  public var focusTime: String
  public var restTime: String
  public var isSelected: Bool

  public init(
    no: Int,
    iconType: PomodoroIconType,
    title: String,
    position: Int,
    focusTime: String,
    restTime: String,
    isSelected: Bool
  ) {
    self.no = no
    self.iconType = iconType
    self.title = title
    self.position = position
    self.focusTime = focusTime
    self.restTime = restTime
    self.isSelected = isSelected
  }
  
  @_spi(Internal)
  public init(managedObject: PomodoroCategoryObject) {
    self.no = managedObject.no
    self.iconType = managedObject.iconType
    self.title = managedObject.title
    self.position = managedObject.position
    self.focusTime = managedObject.focusTime
    self.restTime = managedObject.restTime
    self.isSelected = managedObject.isSelected
  }
  
  @_spi(Internal)
  public func managedObject() -> PomodoroCategoryObject {
    let object = PomodoroCategoryObject()
    object.no = no
    object.iconType = iconType
    object.title = title
    object.position = position
    object.focusTime = focusTime
    object.restTime = restTime
    object.isSelected = isSelected
    return object
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

public enum PomodoroIconType: String, Identifiable, PersistableEnum, Codable, CaseIterable {
  case cat = "CAT"
  case boxPen = "BOX_PEN"
  case openBook = "OPEN_BOOK"
  case briefcase = "BRIEFCASE"
  case laptop = "LAPTOP"
  case dumbbell = "DUMBBELL"
  case lightning = "LIGHTNING"
  case fire = "FIRE"
  case heart = "HEART"
  case asterisk = "ASTERISK"
  case sun = "SUN"
  case moon = "MOON"
}

extension PomodoroIconType {
  public var id: String { rawValue }

  public var image: Image {
    switch self {
    case .fire: DesignSystemAsset.Image.fire.swiftUIImage
    case .lightning: DesignSystemAsset.Image.lightning.swiftUIImage
    case .cat: DesignSystemAsset.Image.cat.swiftUIImage
    case .boxPen: DesignSystemAsset.Image.boxPen.swiftUIImage
    case .openBook: DesignSystemAsset.Image.openBook.swiftUIImage
    case .asterisk: DesignSystemAsset.Image.asterisk.swiftUIImage
    case .heart: DesignSystemAsset.Image.heart.swiftUIImage
    case .laptop: DesignSystemAsset.Image.laptop.swiftUIImage
    case .dumbbell: DesignSystemAsset.Image.dumbbell.swiftUIImage
    case .briefcase: DesignSystemAsset.Image.briefcase.swiftUIImage
    case .moon: DesignSystemAsset.Image.moon.swiftUIImage
    case .sun: DesignSystemAsset.Image.sun.swiftUIImage
    }
  }
}

@_spi(Internal)
public final class PomodoroCategoryObject: Object {
  @Persisted(primaryKey: true) var no: Int
  @Persisted var iconType: PomodoroIconType
  @Persisted var title: String
  @Persisted var position: Int
  @Persisted var focusTime: String
  @Persisted var restTime: String
  @Persisted var isSelected: Bool
}
