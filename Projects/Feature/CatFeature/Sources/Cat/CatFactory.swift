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
  public var keyword: String { base.keyword }
  public var keywordImage: Image { base.keywordImage }
  public var name: String
  public var catImage: Image { base.catImage }
  public var selectCatRivTrigger: String { base.selectCatRivTrigger }
  public var pushNotificationTitle: String { base.pushNotificationTitle }

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
  public var selectCatRivTrigger: String = "Click_Cheese Cat"
  public var pushNotificationTitle: String = "어디갔냐옹..."
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
  public var selectCatRivTrigger: String = "Click_Black Cat"
  public var pushNotificationTitle: String = "어디갔냐옹..."
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
  public var selectCatRivTrigger: String = "Click_Calico Cat"
  public var pushNotificationTitle: String = "내가 여기있는데 어디갔냐옹!"
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
