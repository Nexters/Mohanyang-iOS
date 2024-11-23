//
//  StreamListenerInterface.swift
//  StreamListener
//
//  Created by jihyun247 on 11/21/24.
//

import Foundation

import Dependencies
import DependenciesMacros

/*
 TODO:
 StreamListener를 토스트나 다이얼로그, 에러뷰 등 다양한 상황의 스트림을 만들 수 있도록 둘 것인지, serverState 추적만을 하도록 둘 것인지 정해야함 (네이밍 다시 해야함)
 ++ NetworkTracking도 그 목적이 StreamListener와 유사함
 */

@DependencyClient
public struct StreamListener {
  public var sendServerState: @Sendable (_ state: ServerState) async -> Void
  public var updateServerState: @Sendable () -> AsyncStream<ServerState> = { .never }
}

extension StreamListener: TestDependencyKey {
  public static let previewValue = Self()
  public static let testValue = Self()
}

public enum ServerState {
  case requestStarted
  case requestCompleted
  case errorOccured
}
