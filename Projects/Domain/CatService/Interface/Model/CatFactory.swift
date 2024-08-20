//
//  CatFactory.swift
//  OnboardingFeature
//
//  Created by 김지현 on 8/15/24.
//  Copyright © 2024 PomoNyang. All rights reserved.
//

import SwiftUI
import DesignSystem

public enum CatType: String, Equatable {
  case cheese, black, threeColor
}

// MARK: ANY CAT
public struct AnyCat: CatFactoryProtocol, Identifiable, Equatable {
  private let base: CatFactoryProtocol
  public init(_ base: CatFactoryProtocol) {
    self.base = base
    self.name = base.name
  }

  public var id: String { base.id }
  public var no: Int { base.no }
  public var name: String
  public var keyword: String { base.keyword }
  public var keywordImage: Image { base.keywordImage }
  public var catImage: Image { base.catImage }
  public var rivTriggerName: String { base.rivTriggerName }
  public var rivInputName: String { base.rivInputName }
  public var focusEndPushTitle: String { base.focusEndPushTitle }
  public var restEndPushTitle: String { base.restEndPushTitle }
  public var disturbPushTitle: String { base.disturbPushTitle }
  public var tooltipMessage: String { base.tooltipMessage }

  public static func == (lhs: AnyCat, rhs: AnyCat) -> Bool {
    lhs.base.id == rhs.base.id
  }
}

// MARK: CHEESE CAT
public struct CheeseCat: CatFactoryProtocol {
  public init(no: Int, name: String) {
    self.no = no
    self.name = name
  }

  public var id: String = "CHEESE"
  public var no: Int
  public var name: String
  public var keyword: String = "응원"
  public var keywordImage: Image = DesignSystemAsset.Image._16Star.swiftUIImage
  public var catImage: Image = Image(systemName: "star.fill")
  public var rivTriggerName: String = "Click_Cheese Cat"
  public var rivInputName: String = "cheeseCat"
  public var focusEndPushTitle: String = "집중이 끝났다냥! 이제 나랑 놀아달라냥"
  public var restEndPushTitle: String = "이제 다시 집중해볼까냥?"
  public var disturbPushTitle: String = "날 두고 어디갔냥.."
  
  public var tooltipMessage: String {
    let messages = ["나랑 함께할 시간이다냥!", "자주 와서 쓰다듬어 달라냥", "집중이 잘 될 거 같다냥"]
    return messages.randomElement() ?? ""
  }
}

// MARK: BLACK CAT
public struct BlackCat: CatFactoryProtocol {
  public init(no: Int, name: String) {
    self.no = no
    self.name = name
  }

  public var id: String = "BLACK"
  public var no: Int
  public var name: String
  public var keyword: String = "긍정"
  public var keywordImage: Image = DesignSystemAsset.Image._16Heart.swiftUIImage
  public var catImage: Image = Image(systemName: "star")
  public var rivTriggerName: String = "Click_Black Cat"
  public var rivInputName: String = "blackCat"
  public var focusEndPushTitle: String = "집중이 끝났다냥! 이제 나랑 놀아달라냥"
  public var restEndPushTitle: String = "이제 다시 집중해볼까냥?"
  public var disturbPushTitle: String = "날 두고 어디갔냥.."
  
  public var tooltipMessage: String {
    let messages = ["나랑 함께할 시간이다냥!", "자주 와서 쓰다듬어 달라냥", "집중이 잘 될 거 같다냥"]
    return messages.randomElement() ?? ""
  }
}

// MARK: THREE_COLOR CAT
public struct ThreeColorCat: CatFactoryProtocol {
  public init(no: Int, name: String) {
    self.no = no
    self.name = name
  }

  public var id: String = "THREE_COLOR"
  public var no: Int
  public var name: String
  public var keyword: String = "자극"
  public var keywordImage: Image = DesignSystemAsset.Image._16Focus.swiftUIImage
  public var catImage: Image = Image(systemName: "star.fill")
  public var rivTriggerName: String = "Click_Calico Cat"
  public var rivInputName: String = "calicoCat"
  public var focusEndPushTitle: String = "집중이 끝났다냥! 원하는 만큼 집중했냥?"
  public var restEndPushTitle: String = "집중할 시간이다냥! 빨리 들어오라냥"
  public var disturbPushTitle: String = "지금 뭐하고 있냥? 내가 감시하고 있다냥"
  
  public var tooltipMessage: String {
    let messages = ["\"시간이 없어서\"는 변명이다냥", "휴대폰 그만보고 집중하라냥", "기회란 금새 왔다 사라진다냥"]
    return messages.randomElement() ?? ""
  }
}

// MARK: MAKE CAT
public struct CatFactory {
  public static func makeCat(type: CatType, no: Int, name: String) -> AnyCat {
    let cat: CatFactoryProtocol
    switch type {
    case .cheese:
      cat = CheeseCat(no: no, name: name)
    case .black:
      cat = BlackCat(no: no, name: name)
    case .threeColor:
      cat = ThreeColorCat(no: no, name: name)
    }
    return AnyCat(cat)
  }
}
