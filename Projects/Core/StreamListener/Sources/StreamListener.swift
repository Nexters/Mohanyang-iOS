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
    return .init(protocolAdapter: StreamListenerImpl())
  }
}

final class StreamListenerImpl: StreamListenerProtocol {
  private let actor = StreamActor()

  func send<T: StreamType>(_ state: T) async {
    await actor.yield(type: T.key, value: state)
  }

  func receive<T: StreamType>(_ type: T.Type) -> AsyncStream<T> {
    let (stream, continuation) = AsyncStream<T>.makeStream()
    Task {
      await actor.register(key: T.key, continuation: continuation)
    }
    return stream
  }
}

private actor StreamActor {
  private var streams: [StreamKey: StreamContinuation] = [:]

  func register<T: StreamType>(key: StreamKey, continuation: AsyncStream<T>.Continuation) {
    streams[key] = StreamContinuation(continuation)
  }

  func yield<T: StreamType>(type: StreamKey, value: T) {
    guard let continuation = streams[type] else { return }
    continuation.yield(value)
  }

  func remove(type: StreamKey) {
    streams[type] = nil
  }
}
