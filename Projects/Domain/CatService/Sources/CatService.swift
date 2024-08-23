//
//  CatService.swift
//  CatService
//
//  Created by 김지현 on 8/17/24.
//

import Foundation

@_spi(Internal)
import CatServiceInterface
import APIClientInterface

import Dependencies

extension CatService: DependencyKey {
  public static let liveValue: CatService = .live()
  private static func live() -> Self {
    return CatService(
      getCatList: { apiClient in
        let request = CatAPI.fetchCatList
        return try await apiClient.apiRequest(
          request: request,
          as: [Cat].self
        )
      },
      changeCatName: { apiClient, request in
        let request = CatAPI.changeCatName(request: request)
        _ = try await apiClient.apiRequest(
          request: request,
          as: EmptyResponse.self
        )
      }
    )
  }
}
