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
  /// deprecated: 25.03.17
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

public enum PomodoroIconType: String, PersistableEnum, Codable, CaseIterable {
  case bell = "BELL"
  case fire = "FIRE"
  case lightning = "LIGHTNING"
  case cat = "CAT"
  case monitor = "MONITOR"
  case boxPen = "BOX_PEN"
  case openBook = "OPEN_BOOK"
  case alarm = "ALARM"
  case bubbleEllipses = "BUBBLE_ELLIPSES"
  case asterisk = "ASTERISK"
  case heart = "HEART"
  case checkCircle = "CHECK_CIRCLE"
  case laptop = "LAPTOP"
  case dumbbell = "DUMBBELL"
  case briefcase = "BRIEFCASE"
  case moon = "MOON"
  case sun = "SUN"
}

extension PomodoroIconType {
  public var image: Image {
    switch self {
    case .bell: return DesignSystemAsset.Image.bell.swiftUIImage
    case .fire: return DesignSystemAsset.Image.fire.swiftUIImage
    case .lightning: return DesignSystemAsset.Image.lightning.swiftUIImage
    case .cat: return DesignSystemAsset.Image.cat.swiftUIImage
    case .monitor: return DesignSystemAsset.Image.monitor.swiftUIImage
    case .boxPen: return DesignSystemAsset.Image.boxPen.swiftUIImage
    case .openBook: return DesignSystemAsset.Image.openBook.swiftUIImage
    case .alarm: return DesignSystemAsset.Image.alarm.swiftUIImage
    case .bubbleEllipses: return DesignSystemAsset.Image.bubbleEllipses.swiftUIImage
    case .asterisk: return DesignSystemAsset.Image.asterisk.swiftUIImage
    case .heart: return DesignSystemAsset.Image.heart.swiftUIImage
    case .checkCircle: return DesignSystemAsset.Image.checkCircle.swiftUIImage
    case .laptop: return DesignSystemAsset.Image.laptop.swiftUIImage
    case .dumbbell: return DesignSystemAsset.Image.dumbbell.swiftUIImage
    case .briefcase: return DesignSystemAsset.Image.briefcase.swiftUIImage
    case .moon: return DesignSystemAsset.Image.moon.swiftUIImage
    case .sun: return DesignSystemAsset.Image.sun.swiftUIImage
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
