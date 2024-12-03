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
    private let actor = ContinuationActor()

    func send<T: Hashable>(value: T, for type: StreamType) async {
        await actor.yield(type: type, value: value)
    }

    func receive<T: Hashable>(type: StreamType) -> AsyncStream<T> {
        let (stream, continuation) = AsyncStream<T>.makeStream()

        Task {
            await actor.set(type: type, continuation: continuation)
        }

        return stream
    }
}

private actor ContinuationActor {
    private var continuations: [StreamType: AsyncStream<Any>.Continuation] = [:]

    func set<T>(type: StreamType, continuation: AsyncStream<T>.Continuation) {
        continuations[type] = continuation as? AsyncStream<Any>.Continuation
    }

    func yield<T>(type: StreamType, value: T) {
        continuations[type]?.yield(value)
    }

    func remove(type: StreamType) {
        continuations[type] = nil
    }
}
