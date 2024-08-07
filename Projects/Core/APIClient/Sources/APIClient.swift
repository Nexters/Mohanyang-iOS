//
//  APIClient.swift
//  APIClient
//
//  Created by 김지현 on 8/6/24.
//  Copyright © 2024 PomoNyang. All rights reserved.
//

import Foundation

import Logger
import APIClientInterface

import Dependencies

extension APIClient {
  public static let liveValue: APIClient = .live()

  public static func live() -> Self {
    guard let baseURL = Bundle.main.object(forInfoDictionaryKey: "BASE_URL") as? String else {
      fatalError("url missing")
    }

    let tokenInterceptor = TokenInterceptor()
    let session = Session(tokenInterceptor: tokenInterceptor)

    return .init(
      apiRequest: { request, token in
        return try await session.sendRequest(request: request)
      }
    )
  }
}
