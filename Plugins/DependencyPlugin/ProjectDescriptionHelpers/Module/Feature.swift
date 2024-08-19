//
//  Feature.swift
//  DependencyPlugin
//
//  Created by devMinseok on 7/20/24.
//

import Foundation

@_spi(Feature)
public enum Feature: String, Modulable {
  case SplashFeature
  case HomeFeature
  case OnboardingFeature
  case MyPageFeature
  case CatFeature
}
