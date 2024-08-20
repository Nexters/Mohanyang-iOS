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

extension NetworkTracking {
  public static let liveValue: NetworkTracking = .live()

  public static func live() -> NetworkTracking {
    let networkMonitor = NWPathMonitor()
    return NetworkTracking(
      start: {
        networkMonitor.start(queue: DispatchQueue.global())
      },
      updateNetworkConnected: {
        return AsyncThrowingStream<Bool, Error> { continuation in
          networkMonitor.pathUpdateHandler = { path in
            let isConnected = path.status == .satisfied ? true : false
            continuation.yield(isConnected)
          }
        }
      },
      cancel: {
        networkMonitor.cancel()
      }
    )
  }
}
