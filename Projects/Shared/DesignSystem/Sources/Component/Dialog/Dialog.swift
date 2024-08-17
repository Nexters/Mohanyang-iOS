//
//  Dialog.swift
//  DesignSystem
//
//  Created by 김지현 on 8/18/24.
//  Copyright © 2024 PomoNyang. All rights reserved.
//

import SwiftUI

public struct DialogButtonModel: Equatable {
  public static func == (lhs: DialogButtonModel, rhs: DialogButtonModel) -> Bool {
    lhs.title == rhs.title
  }
  
  let title: String
  let leftIcon: Image?
  let rightIcon: Image?
  let action: (() -> Void)? // 버튼 액션을 Nil로 두면 자동으로 CancelButton이 됩니다

  public init(title: String, leftIcon: Image? = nil, rightIcon: Image? = nil, action: (() -> Void)? = nil) {
    self.title = title
    self.leftIcon = leftIcon
    self.rightIcon = rightIcon
    self.action = action
  }
}

public protocol Dialog: Equatable {
  var title: String { get }
  var subTitle: String? { get }
  var firstButton: DialogButtonModel { get }
  var secondButton: DialogButtonModel? { get }
}

public struct DefaultDialog: Dialog {
  public var title: String
  public var subTitle: String?
  public var firstButton: DialogButtonModel
  public var secondButton: DialogButtonModel?

  public init(
    title: String,
    subTitle: String? = nil,
    firstButton: DialogButtonModel,
    secondButton: DialogButtonModel? = nil
  ) {
    self.title = title
    self.subTitle = subTitle
    self.firstButton = firstButton
    self.secondButton = secondButton
  }
}
