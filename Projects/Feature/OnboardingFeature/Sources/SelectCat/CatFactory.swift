//
//  CatFactory.swift
//  OnboardingFeature
//
//  Created by 김지현 on 8/15/24.
//  Copyright © 2024 PomoNyang. All rights reserved.
//

import SwiftUI

import DesignSystem

public enum CatType {
  case cheese, black, calico
}

public protocol CatFactoryProtocol {
  var keyword: String { get }
  var keywordImage: Image { get }
  var typeName: String { get }
  var catImage: Image { get }
  var pushNotificationTitle: String { get }
}

public struct CheeseCat: CatFactoryProtocol {
  public var keyword: String = "응원"
  public var keywordImage: Image = DesignSystemAsset.Image._16Star.swiftUIImage
  public var typeName: String = "치즈냥"
  public var catImage: Image = Image(systemName: "star.fill")
  public var pushNotificationTitle: String = "어디갔냐옹..."
}

public struct BlackCat: CatFactoryProtocol {
  public var keyword: String = "긍정"
  public var keywordImage: Image = DesignSystemAsset.Image._16Heart.swiftUIImage
  public var typeName: String = "까만냥"
  public var catImage: Image = Image(systemName: "star")
  public var pushNotificationTitle: String = "어디갔냐옹..."
}

public struct CalicoCat: CatFactoryProtocol {
  public var keyword: String = "자극"
  public var keywordImage: Image = DesignSystemAsset.Image._16Focus.swiftUIImage
  public var typeName: String = "삼색냥"
  public var catImage: Image = Image(systemName: "star.fill")
  public var pushNotificationTitle: String = "내가 여기있는데 어디갔냐옹!"
}

public struct CatFactory {
  public static func makeCat(type: CatType) -> CatFactoryProtocol {
    switch type {
    case .cheese:
      return CheeseCat()
    case .black:
      return BlackCat()
    case .calico:
      return CalicoCat()
    }
  }
}
