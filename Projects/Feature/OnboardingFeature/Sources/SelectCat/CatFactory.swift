//
//  CatFactory.swift
//  OnboardingFeature
//
//  Created by 김지현 on 8/15/24.
//  Copyright © 2024 PomoNyang. All rights reserved.
//

import SwiftUI
import DesignSystem

public protocol CatFactoryProtocol {
  var keyword: LocalizedStringKey { get }
  var keywordImage: Image { get }
  var typeName: LocalizedStringKey { get }
  var catImage: Image { get }
  var pushNotificationTitle: String { get }
}

public enum CatType: String, CaseIterable, Identifiable {
  public var id: String { self.rawValue }
  case cheese, black, calico
}

extension CatType: CatFactoryProtocol {
  public var keyword: LocalizedStringKey {
    switch self {
    case .cheese:
      "응원"
    case .black:
      "긍정"
    case .calico:
      "자극"
    }
  }
  
  public var keywordImage: Image {
    switch self {
    case .cheese:
      DesignSystemAsset.Image._16Star.swiftUIImage
    case .black:
      DesignSystemAsset.Image._16Heart.swiftUIImage
    case .calico:
      DesignSystemAsset.Image._16Focus.swiftUIImage
    }
  }
  
  public var typeName: LocalizedStringKey {
    switch self {
    case .cheese:
      "치즈냥"
    case .black:
      "까만냥"
    case .calico:
      "삼색냥"
    }
  }
  
  public var catImage: Image {
    switch self {
    case .cheese:
      Image(systemName: "star.fill")
    case .black:
      Image(systemName: "star.fill")
    case .calico:
      Image(systemName: "star.fill")
    }
  }
  
  public var pushNotificationTitle: String {
    switch self {
    case .cheese:
      "어디갔냐옹..."
    case .black:
      "어디갔냐옹..."
    case .calico:
      "내가 여기있는데 어디갔냐옹!"
    }
  }
}
