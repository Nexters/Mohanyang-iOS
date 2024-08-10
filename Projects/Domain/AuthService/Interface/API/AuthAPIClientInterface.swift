//
//  AuthClient.swift
//  AuthService
//
//  Created by 김지현 on 8/3/24.
//  Copyright © 2024 PomoNyang. All rights reserved.
//

import Foundation

import APIClientInterface
import KeychainClientInterface
import UserDefaultsClientInterface

import Dependencies
import DependenciesMacros


@DependencyClient
public struct AuthService {
  public var login: @Sendable (
    _ deviceID: String,
    _ apiClient: APIClient,
    _ keychainClient: KeychainClient
  ) async throws -> Void
}

extension AuthService: TestDependencyKey {
  public static let previewValue = Self()
  public static let testValue = Self()
}
