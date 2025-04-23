//
//  EventData.swift
//  AnalyticsClient
//
//  Created by devMinseok on 4/22/25.
//  Copyright © 2025 PomoNyang. All rights reserved.
//

public struct EventData {
  public let name: String
  public let properties: [String: Any]?

  public init(
    name: String,
    properties: [String: Any]? = nil
  ) {
    self.name = name
    self.properties = properties
  }
}
