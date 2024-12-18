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

  func send<T: StreamTypeProtocol>(_ state: T) async {
    await actor.yield(type: T.key, value: T.self)
  }

  func receive<T: StreamTypeProtocol>(_ type: T.Type) -> AsyncStream<T> {
    let (stream, continuation) = AsyncStream<T>.makeStream()
    Task {
      await actor.register(key: T.key, continuation: continuation)
    }
    return stream
  }
}

private actor StreamActor {
  private var streams: [StreamType: AnyStreamContinuation] = [:]

  func register<T: StreamTypeProtocol>(key: StreamType, continuation: AsyncStream<T>.Continuation) {
    streams[key] = AnyStreamContinuation(continuation)
  }

  func yield<T: StreamTypeProtocol>(type: StreamType, value: T.Type) {
    guard let continuation = streams[type] else { return }
    continuation.yield(value)
  }

  func remove(type: StreamType) {
    streams[type] = nil
  }
}
