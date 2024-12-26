//
//  ServerStateStream.swift
//  AppService
//
//  Created by 김지현 on 12/25/24.
//  Copyright © 2024 PomoNyang. All rights reserved.
//

import StreamListenerInterface

public enum ServerState: StreamType {
  public static var key: StreamKey { "serverState" }
  case requestStarted
  case requestCompleted
  case errorOccured
  case networkDisabled
}

public struct RetryState: StreamType {
  public static var key: StreamKey { "retryState" }
  public var retry: Int?
}
