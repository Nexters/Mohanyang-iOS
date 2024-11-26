//
//  TestKey.swift
//  LiveActivityClientInterface
//
//  Created by devMinseok on 11/27/24.
//  Copyright © 2024 PomoNyang. All rights reserved.
//

import ActivityKit

import Dependencies

extension LiveActivityClient: TestDependencyKey {
  public static let previewValue = Self(protocolAdapter: LiveActivityClientImplTest())
  public static let testValue = Self(protocolAdapter: LiveActivityClientImplTest())
}

class LiveActivityClientImplTest: LiveActivityClientProtocol {
  func isLiveActivityAllowed() -> Bool {
    return false
  }
  
  func startActivity<T: ActivityAttributes>(
    attributes: T,
    content: ActivityContent<Activity<T>.ContentState>,
    pushType: PushType?
  ) throws -> Activity<T>? {
    return nil
  }
  
  func updateActivity<T: ActivityAttributes>(
    _ activity: T.Type,
    id: String,
    content: ActivityContent<Activity<T>.ContentState>
  ) async {}
  
  func endActivity<T: ActivityAttributes>(
    _ activity: T.Type,
    id: String,
    content: ActivityContent<Activity<T>.ContentState>?,
    dismissalPolicy: ActivityUIDismissalPolicy
  ) async {}
  
  func endAllActivityImmediately<T: ActivityAttributes>(
    type: T.Type
  ) async {}
}
