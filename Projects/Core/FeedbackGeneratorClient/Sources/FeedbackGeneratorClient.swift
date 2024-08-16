//
//  FeedbackGeneratorClient.swift
//  FeedbackGeneratorClient
//
//  Created by devMinseok on 8/16/24.
//

import UIKit

import FeedbackGeneratorClientInterface

import Dependencies

extension FeedbackGeneratorClient: DependencyKey {
  public static let liveValue: FeedbackGeneratorClient = .live()
  
  public static func live() -> FeedbackGeneratorClient {
    return .init(
      notification: { type in
        let generator = await UINotificationFeedbackGenerator()
        await generator.notificationOccurred(type)
      },
      selectionChanged: {
        let generator = await UISelectionFeedbackGenerator()
        await generator.selectionChanged()
      },
      impactOccurred: { style in
        let generator = await UIImpactFeedbackGenerator(style: style)
        await generator.impactOccurred()
      }
    )
  }
}
