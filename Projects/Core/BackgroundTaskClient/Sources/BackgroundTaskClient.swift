//
//  BackgroundTaskClient.swift
//  BackgroundTaskClient
//
//  Created by MinseokKang on 12/5/24.
//

import Foundation
import BackgroundTasks

import BackgroundTaskClientInterface

import Dependencies

extension BackgroundTaskClient: DependencyKey {
  public static let liveValue: BackgroundTaskClient = .live()
  
  public static func live() -> BackgroundTaskClient {
    let backgroundTaskScheduler = BGTaskScheduler.shared
    
    return .init(
      registerTask: { identifier, queue, handler in
        return backgroundTaskScheduler.register(forTaskWithIdentifier: identifier, using: queue, launchHandler: handler)
      },
      submit: { request in
        try backgroundTaskScheduler.submit(request)
      },
      cancel: { identifier in
        backgroundTaskScheduler.cancel(taskRequestWithIdentifier: identifier)
      },
      cancelAllTaskRequests: {
        backgroundTaskScheduler.cancelAllTaskRequests()
      },
      pendingTaskRequests: {
        await backgroundTaskScheduler.pendingTaskRequests()
      }
    )
  }
}
