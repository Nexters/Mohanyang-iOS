//
//  LiveActivityClient.swift
//  LiveActivityClient
//
//  Created by MinseokKang on 11/23/24.
//

import ActivityKit

import LiveActivityClientInterface

import Dependencies

extension LiveActivityClient: DependencyKey {
  public static let liveValue: LiveActivityClient = .live()
  
  public static func live() -> LiveActivityClient {
    return .init(protocolAdapter: LiveActivityClientImpl())
  }
}

// MARK: - Protocol 추상화 구현

final class LiveActivityClientImpl: LiveActivityClientProtocol {
  public func isLiveActivityAllowed() -> Bool {
    return ActivityAuthorizationInfo().areActivitiesEnabled
  }
  
  public func startActivity<T: ActivityAttributes>(
    attributes: T,
    content: ActivityContent<Activity<T>.ContentState>,
    pushType: PushType?
  ) throws -> Activity<T>? {
    guard ActivityAuthorizationInfo().areActivitiesEnabled else { return nil }
    
    return try Activity.request(
      attributes: attributes,
      content: content,
      pushType: pushType
    )
  }
  
  public func updateActivity<T: ActivityAttributes>(
    _ activity: T.Type,
    id: String,
    content: ActivityContent<Activity<T>.ContentState>
  ) async {
    let activity = Activity<T>.activities.first { $0.id == id }
    await activity?.update(content, alertConfiguration: nil)
  }
  
  public func endActivity<T: ActivityAttributes>(
    _ activity: T.Type,
    id: String,
    content: ActivityContent<Activity<T>.ContentState>?,
    dismissalPolicy: ActivityUIDismissalPolicy
  ) async {
    let activity = Activity<T>.activities.first { $0.id == id }
    await activity?.end(content, dismissalPolicy: dismissalPolicy)
  }
  
  public func endAllActivityImmediately<T: ActivityAttributes>(
    type: T.Type
  ) async {
    for activity in Activity<T>.activities {
      await activity.end(nil, dismissalPolicy: .immediate)
    }
  }
  
  func getActivities<T: ActivityAttributes>(type: T.Type) -> [Activity<T>] {
    return Activity<T>.activities
  }
}
