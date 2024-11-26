//
//  Dialog.swift
//  DesignSystem
//
//  Created by 김지현 on 8/18/24.
//  Copyright © 2024 PomoNyang. All rights reserved.
//

import SwiftUI

public struct DialogButtonModel: Equatable {
  let title: String
  let leftIcon: Image?
  let rightIcon: Image?
  
  /// nil로 설정시 CancelButton이 됩니다.
  var action: (() async -> Void)?

  public init(
    title: String,
    leftIcon: Image? = nil,
    rightIcon: Image? = nil,
    action: (() async -> Void)? = nil
  ) {
    self.title = title
    self.leftIcon = leftIcon
    self.rightIcon = rightIcon
    self.action = action
  }
  
  public static func == (lhs: DialogButtonModel, rhs: DialogButtonModel) -> Bool {
    return lhs.title == rhs.title &&
    lhs.leftIcon == rhs.leftIcon &&
    lhs.rightIcon == rhs.rightIcon
  }
}

public protocol Dialog: Equatable {
  var title: String { get }
  var subTitle: String? { get }
  var firstButton: DialogButtonModel { get }
  var secondButton: DialogButtonModel? { get }
  var showCloseButton: Bool { get }
}

public struct DefaultDialog: Dialog {
  public var title: String
  public var subTitle: String?
  public var firstButton: DialogButtonModel
  public var secondButton: DialogButtonModel?
  public var showCloseButton: Bool

  public init(
    title: String,
    subTitle: String? = nil,
    firstButton: DialogButtonModel,
    secondButton: DialogButtonModel? = nil,
    showCloseButton: Bool
  ) {
    self.title = title
    self.subTitle = subTitle
    self.firstButton = firstButton
    self.secondButton = secondButton
    self.showCloseButton = showCloseButton
  }
}
