//
//  Shared.swift
//  DependencyPlugin
//
//  Created by devMinseok on 7/20/24.
//

import Foundation

@_spi(Shared)
public enum Shared: String, Modulable {
  case DesignSystem
  case Utils
  case Logger
  case ThirdParty_SPM
  case ThirdParty_Realm
  case ThirdParty_Firebase
}
