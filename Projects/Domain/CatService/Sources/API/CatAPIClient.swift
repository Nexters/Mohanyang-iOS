//
//  CatService.swift
//  CatService
//
//  Created by 김지현 on 8/17/24.
//

import Foundation

import APIClientInterface
import CatServiceInterface

import Dependencies

extension CatService: DependencyKey {
  public static let liveValue: CatService = .live()
  private static func live() -> Self {
    return CatService(
      fetchCatLists: { apiClient in
        let request = CatAPIrequest.fetchCatList
        return try await apiClient.apiRequest(
          request: request,
          as: CatList.self
        )
      },

      changeCatName: { apiClient, name in
        let request = CatAPIrequest.changeCatName(name)
        _ = try await apiClient.apiRequest(
          request: request,
          as: EmptyResponse.self
        )
      }
    )
  }
}
