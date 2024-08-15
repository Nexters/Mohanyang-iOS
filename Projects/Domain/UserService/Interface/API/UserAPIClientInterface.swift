//
//  UserAPIClientInterface.swift
//  UserService
//
//  Created by 김지현 on 8/16/24.
//  Copyright © 2024 PomoNyang. All rights reserved.
//

import Foundation

import APIClientInterface

import Dependencies
import DependenciesMacros


@DependencyClient
public struct UserService {
  public var getCatLists: @Sendable (
    _ apiClient: APIClient
  ) async throws -> CatList
}

extension UserService: TestDependencyKey {
  public static let previewValue = Self()
  public static let testValue = Self()
}
