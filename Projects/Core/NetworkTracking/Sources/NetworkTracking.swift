//
//  NetworkTracking.swift
//  NetworkTracking
//
//  Created by 김지현 on 8/21/24.
//

import Foundation
import Network

import NetworkTrackingInterface

import Dependencies

extension NetworkTracking: DependencyKey {
  public static let liveValue: NetworkTracking = .live()

  public static func live() -> NetworkTracking {
    let networkMonitor = NWPathMonitor()
    let globalQueue = DispatchQueue.global()

    return NetworkTracking(
      updateNetworkConnected: {
        networkMonitor.start(queue: globalQueue)
        return AsyncStream<Bool> { continuation in
          let initialState = networkMonitor.currentPath.status == .satisfied ? true : false
          continuation.yield(initialState)

          networkMonitor.pathUpdateHandler = { path in
            let isConnected = path.status == .satisfied ? true : false
            continuation.yield(isConnected)
          }

          continuation.onTermination = { _ in
            networkMonitor.cancel()
          }
        }
      }
    )
  }
}
