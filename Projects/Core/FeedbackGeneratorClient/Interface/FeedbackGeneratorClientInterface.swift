//
//  FeedbackGeneratorClientInterface.swift
//  FeedbackGeneratorClient
//
//  Created by devMinseok on 8/16/24.
//

import UIKit

import Dependencies
import DependenciesMacros

@DependencyClient
public struct FeedbackGeneratorClient {
  public var notification: @Sendable (UINotificationFeedbackGenerator.FeedbackType) async -> Void
  public var selectionChanged: @Sendable () async -> Void
  public var impactOccurred: @Sendable (UIImpactFeedbackGenerator.FeedbackStyle) async -> Void
}

extension FeedbackGeneratorClient: TestDependencyKey {
  public static let previewValue = Self()
  public static let testValue = Self()
}
