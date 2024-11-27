//
//  AudioClientInterface.swift
//  AudioClient
//
//  Created by MinseokKang on 11/27/24.
//

import Foundation
import AVFoundation

import Dependencies
import DependenciesMacros

@DependencyClient
public struct AudioClient {
  public var playSound: @Sendable (_ fileURL: URL) async throws -> Bool
}

extension AudioClient: TestDependencyKey {
  public static let previewValue = Self()
  public static let testValue = Self()
}
