//
//  AnalyticsClientInterface.swift
//  AnalyticsClient
//
//  Created by devMinseok on 4/22/25.
//

import Dependencies
import DependenciesMacros

@DependencyClient
public struct AnalyticsClient {
  public var sendEvent: @Sendable (_ data: EventData) -> Void
  public var initialize: @Sendable (_ userId: String) -> Void
}
