//
//  TestKey.swift
//  AnalyticsClient
//
//  Created by devMinseok on 4/22/25.
//  Copyright © 2025 PomoNyang. All rights reserved.
//

import Dependencies

extension AnalyticsClient: TestDependencyKey {
  public static let previewValue = Self()
  public static let testValue = Self()
}
