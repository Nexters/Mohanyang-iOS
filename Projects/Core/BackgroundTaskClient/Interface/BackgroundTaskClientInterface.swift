//
//  BackgroundTaskClientInterface.swift
//  BackgroundTaskClient
//
//  Created by MinseokKang on 12/5/24.
//

import Foundation
import BackgroundTasks

import Dependencies
import DependenciesMacros

@DependencyClient
public struct BackgroundTaskClient {
  public var registerTask: @Sendable (
    _ identifier: String,
    _ queue: DispatchQueue?,
    _ launchHandler: @escaping (BGTask) -> Void
  ) -> Bool = { _, _, _ in false }
  
  public var submit: @Sendable (_ taskRequest: BGTaskRequest) throws -> Void
  
  public var cancel: @Sendable (_ identifier: String) -> Void
  
  public var cancelAllTaskRequests: @Sendable () -> Void
  
  public var pendingTaskRequests: () async -> [BGTaskRequest] = { [] }
}
