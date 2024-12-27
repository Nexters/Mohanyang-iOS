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
    await actor.yield(key: T.key, value: state)
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
  private var streams: [StreamKey: [StreamContinuation]] = [:]

  func register<T: StreamType>(key: StreamKey, continuation: AsyncStream<T>.Continuation) {
    let newContinuation = StreamContinuation(continuation)
    if streams[key] == nil {
      streams[key] = [newContinuation]
    } else {
      streams[key]?.append(newContinuation)
    }
  }

  func yield<T: StreamType>(key: StreamKey, value: T) {
    guard let continuations = streams[key] else { return }
    continuations.forEach { $0.yield(value) }
  }

  func remove(key: StreamKey) {
    streams[key]?.forEach { $0.finish() }
    streams[key] = nil
  }
}
