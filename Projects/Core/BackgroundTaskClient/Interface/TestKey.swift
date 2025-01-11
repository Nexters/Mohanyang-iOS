//
//  TestKey.swift
//  BackgroundTaskClientInterface
//
//  Created by devMinseok on 12/5/24.
//  Copyright © 2024 PomoNyang. All rights reserved.
//

import Dependencies

extension BackgroundTaskClient: TestDependencyKey {
  public static let previewValue = Self()
  public static let testValue = Self()
}
