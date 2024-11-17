//
//  CatTemplate.swift
//  CatServiceInterface
//
//  Created by devMinseok on 8/23/24.
//  Copyright © 2024 PomoNyang. All rights reserved.
//

import SwiftUI

import DesignSystem

public protocol CatTemplate: Equatable {
  var baseInfo: Cat { get }
  var keyword: String { get }
  var keywordImage: Image { get }
  var rivTriggerName: String { get }
  var rivInputName: String { get }
  var focusEndPushTitle: String { get }
  var restEndPushTitle: String { get }
  var disturbPushTitle: String { get }
  
  init(baseInfo: Cat)
  
  mutating func generateTooltipMessage() -> String
}


// MARK: - Impl

struct CheeseCat: CatTemplate {
  public let baseInfo: Cat
  
  var keyword: String = "응원"
  var keywordImage: Image = DesignSystemAsset.Image._16Star.swiftUIImage
  var rivTriggerName: String = "Click_Cheese Cat"
  var rivInputName: String = "cheeseCat"
  var focusEndPushTitle: String = "집중이 끝났다냥! 이제 나랑 놀아달라냥"
  var restEndPushTitle: String = "이제 다시 집중해볼까냥?"
  var disturbPushTitle: String = "날 두고 어디갔냥.."
  
  let tooltipMessages = ["나랑 함께할 시간이다냥!", "자주 와서 쓰다듬어 달라냥", "집중이 잘 될 거 같다냥"]
  var tooltipMessageCounter: Int = 0
  
  public init(baseInfo: Cat) {
    self.baseInfo = baseInfo
  }
  
  mutating func generateTooltipMessage() -> String {
    let index = tooltipMessageCounter % tooltipMessages.count
    tooltipMessageCounter += 1
    return tooltipMessages[index]
  }
}


struct BlackCat: CatTemplate {
  public let baseInfo: Cat
  
  var keyword: String = "긍정"
  var keywordImage: Image = DesignSystemAsset.Image._16Heart.swiftUIImage
  var rivTriggerName: String = "Click_Black Cat"
  var rivInputName: String = "blackCat"
  var focusEndPushTitle: String = "집중이 끝났다냥! 이제 나랑 놀아달라냥"
  var restEndPushTitle: String = "이제 다시 집중해볼까냥?"
  var disturbPushTitle: String = "날 두고 어디갔냥.."
  
  let tooltipMessages = ["나랑 함께할 시간이다냥!", "자주 와서 쓰다듬어 달라냥", "집중이 잘 될 거 같다냥"]
  var tooltipMessageCounter: Int = 0
  
  public init(baseInfo: Cat) {
    self.baseInfo = baseInfo
  }
  
  mutating func generateTooltipMessage() -> String {
    let index = tooltipMessageCounter % tooltipMessages.count
    tooltipMessageCounter += 1
    return tooltipMessages[index]
  }
}


struct ThreeColorCat: CatTemplate {
  let baseInfo: Cat
  
  var keyword: String = "자극"
  var keywordImage: Image = DesignSystemAsset.Image._16Focus.swiftUIImage
  var rivTriggerName: String = "Click_Calico Cat"
  var rivInputName: String = "calicoCat"
  var focusEndPushTitle: String = "집중이 끝났다냥! 원하는 만큼 집중했냥?"
  var restEndPushTitle: String = "집중할 시간이다냥! 빨리 들어오라냥"
  var disturbPushTitle: String = "지금 뭐하고 있냥? 내가 감시하고 있다냥"
  
  let tooltipMessages = ["\"시간이 없어서\"는 변명이다냥", "휴대폰 그만보고 집중하라냥", "기회란 금새 왔다 사라진다냥"]
  var tooltipMessageCounter: Int = 0
  
  init(baseInfo: Cat) {
    self.baseInfo = baseInfo
  }
  
  mutating func generateTooltipMessage() -> String {
    let index = tooltipMessageCounter % tooltipMessages.count
    tooltipMessageCounter += 1
    return tooltipMessages[index]
  }
}
