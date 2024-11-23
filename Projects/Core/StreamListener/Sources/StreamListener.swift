//
//  StreamListener.swift
//  StreamListener
//
//  Created by jihyun247 on 11/21/24.
//

import Foundation

import StreamListenerInterface

import Dependencies

extension StreamListener: DependencyKey {
  public static let liveValue: StreamListener = .live()

  public static func live() -> StreamListener {

    // 네이밍 추천 plz .,
    actor ContinuationActor {
      var continuation: AsyncStream<ServerState>.Continuation?

      func set(_ newContinuation: AsyncStream<ServerState>.Continuation) {
        continuation = newContinuation
      }

      func yield(_ state: ServerState) {
        continuation?.yield(state)
      }
    }

    let continuationActor = ContinuationActor()
    let asyncStream = AsyncStream<ServerState> { continuation in
      Task { await continuationActor.set(continuation) }
    }

    return StreamListener(
      sendServerState: { state in
        await continuationActor.yield(state)
      },
      updateServerState: {
        return asyncStream
      }
    )
  }
}
