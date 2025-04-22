//
//  AnalyticsClient.swift
//  AnalyticsClient
//
//  Created by devMinseok on 4/22/25.
//

import Foundation

import AnalyticsClientInterface
import FirebaseAnalytics

import Dependencies

extension AnalyticsClient: @retroactive DependencyKey {
  public static let liveValue: AnalyticsClient = .live()

  public static func live() -> AnalyticsClient {
    return .init(
      sendEvent: { eventData in
        Analytics.logEvent(eventData.name, parameters: eventData.properties)
      },
      initialize: { userId in
        Analytics.setUserID(userId)
      }
    )
  }
}
