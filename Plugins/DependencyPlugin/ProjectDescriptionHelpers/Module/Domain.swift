//
//  Domain.swift
//  DependencyPlugin
//
//  Created by devMinseok on 7/20/24.
//

import Foundation

@_spi(Domain)
public enum Domain: String, Modulable {
  case AppService
  case AuthService
  case PushService
}
