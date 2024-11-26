//
//  SomeCat.swift
//  CatServiceInterface
//
//  Created by devMinseok on 8/23/24.
//  Copyright © 2024 PomoNyang. All rights reserved.
//

import SwiftUI

import DesignSystem

public struct SomeCat: CatTemplate, Identifiable {
  public var id: Int {
    return baseInfo.no
  }
  
  private var template: any CatTemplate
  
  public var baseInfo: Cat { template.baseInfo }
  public var keyword: String { template.keyword }
  public var keywordImage: Image { template.keywordImage }
  public var rivTriggerName: String { template.rivTriggerName }
  public var rivInputName: String { template.rivInputName }
  public var focusEndPushTitle: String { template.focusEndPushTitle }
  public var restEndPushTitle: String { template.restEndPushTitle }
  public var disturbPushTitle: String { template.disturbPushTitle }
  
  public init(baseInfo data: Cat) {
    switch data.type {
    case .cheese:
      self.template = CheeseCat(baseInfo: data)
    case .black:
      self.template = BlackCat(baseInfo: data)
    case .threeColor:
      self.template = ThreeColorCat(baseInfo: data)
    }
  }
  
  public mutating func generateTooltipMessage() -> String {
    template.generateTooltipMessage()
  }
  
  public static func == (lhs: SomeCat, rhs: SomeCat) -> Bool {
    return lhs.baseInfo == rhs.baseInfo &&
    lhs.keyword == rhs.keyword &&
    lhs.keywordImage == rhs.keywordImage &&
    lhs.rivTriggerName == rhs.rivTriggerName &&
    lhs.rivInputName == rhs.rivInputName &&
    lhs.focusEndPushTitle == rhs.focusEndPushTitle &&
    lhs.restEndPushTitle == rhs.restEndPushTitle &&
    lhs.disturbPushTitle == rhs.disturbPushTitle
  }
}
