//
//  NetworkTrackingInterface.swift
//  NetworkTracking
//
//  Created by 김지현 on 8/21/24.
//

import Foundation
import Network

import Dependencies
import DependenciesMacros

@DependencyClient
public struct NetworkTracking {
  public var updateNetworkConnected: @Sendable () -> AsyncStream<Bool> = { .never }
}

extension NetworkTracking: TestDependencyKey {
  public static let previewValue = Self()
  public static let testValue = Self()
}
