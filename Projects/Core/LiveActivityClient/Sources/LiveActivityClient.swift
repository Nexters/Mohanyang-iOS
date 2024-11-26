//
//  LiveActivityClient.swift
//  LiveActivityClient
//
//  Created by MinseokKang on 11/23/24.
//

import Foundation

import LiveActivityClientInterface

import Dependencies

extension LiveActivityClient: DependencyKey {
  public static let liveValue: LiveActivityClient = .live()
  
  public static func live() -> LiveActivityClient {
    
  }
}

extension LiveActivityClient: TestDependencyKey {
  public static let previewValue = Self()
  public static let testValue = Self()
}
