//
//  Core.swift
//  DependencyPlugin
//
//  Created by devMinseok on 7/20/24.
//

import Foundation

@_spi(Core)
public enum Core: String, Modulable {
  case APIClient
  case KeychainClient
  case UserNotificationClient
  case DatabaseClient
  case UserDefaultsClient
  case FeedbackGeneratorClient
  case NetworkTracking
}
