//
//  LiveActivityClientInterface.swift
//  LiveActivityClient
//
//  Created by MinseokKang on 11/23/24.
//

import Foundation
import ActivityKit

import Dependencies

public struct LiveActivityClient {
  public var protocolAdapter: LiveActivityClientProtocol
  
  public init(protocolAdapter: LiveActivityClientProtocol) {
    self.protocolAdapter = protocolAdapter
  }
}


// MARK: - Protocol 추상화

public protocol LiveActivityClientProtocol {
  func isLiveActivityAllowed() -> Bool
  
  func startActivity<T: ActivityAttributes>(
    attributes: T,
    content: ActivityContent<Activity<T>.ContentState>,
    pushType: PushType?
  ) throws -> Activity<T>?
  
  func updateActivity<T: ActivityAttributes>(
    _ activity: T.Type,
    id: String,
    content: ActivityContent<Activity<T>.ContentState>
  ) async
  
  func endActivity<T: ActivityAttributes>(
    _ activity: T.Type,
    id: String,
    content: ActivityContent<Activity<T>.ContentState>?,
    dismissalPolicy: ActivityUIDismissalPolicy
  ) async
  
  func endAllActivityImmediately<T: ActivityAttributes>(
    type: T.Type
  ) async
  
  func getActivities<T: ActivityAttributes>(type: T.Type) -> [Activity<T>]
}
