//
//  CatServiceInterface.swift
//  CatService
//
//  Created by 김지현 on 8/17/24.
//

import Foundation

import APIClientInterface

import Dependencies
import DependenciesMacros

@DependencyClient
public struct CatService {
  public var getCatList: @Sendable (_ apiClient: APIClient) async throws -> [Cat]
  public var changeCatName: @Sendable (_ apiClient: APIClient, _ request: ChangeCatNameRequest) async throws -> Void
}

extension CatService: TestDependencyKey {
  public static let previewValue = Self()
  public static let testValue = Self()
}
