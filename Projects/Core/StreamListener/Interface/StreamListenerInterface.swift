//
//  StreamListenerInterface.swift
//  StreamListener
//
//  Created by jihyun247 on 11/21/24.
//

import Foundation

import Dependencies
import DependenciesMacros

public protocol StreamListenerProtocol {
    func send<T: Hashable>(value: T, for type: StreamType) async
    func receive<T: Hashable>(type: StreamType) -> AsyncStream<T>
}

@DependencyClient
public struct StreamListener {
    public var protocolAdapter: StreamListenerProtocol
    
    public init(protocolAdapter: StreamListenerProtocol) {
        self.protocolAdapter = protocolAdapter
    }
}

extension StreamListener: TestDependencyKey {
    public static let previewValue = Self(protocolAdapter: StreamListenerTestImpl())
    public static let testValue = Self(protocolAdapter: StreamListenerTestImpl())
}

private struct StreamListenerTestImpl: StreamListenerProtocol {
    func send<T: Hashable>(value: T, for type: StreamType) async {}
    func receive<T: Hashable>(type: StreamType) -> AsyncStream<T> { .never }
}

public enum StreamType: Hashable {
    case serverState
    case retry
    case toast
}

public enum ServerState: Hashable {
    case requestStarted
    case requestCompleted
    case errorOccured
    case networkDisabled
}
