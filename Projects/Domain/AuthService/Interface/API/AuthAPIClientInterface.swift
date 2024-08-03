//
//  AuthClient.swift
//  AuthService
//
//  Created by 김지현 on 8/3/24.
//  Copyright © 2024 PomoNyang. All rights reserved.
//

import Foundation
import Dependencies
import DependenciesMacros
import KeychainClientInterface


@DependencyClient
public struct AuthAPIClient {
  public var getToken: @Sendable (_ deviceID: String) async throws -> AuthDTO.Response.TokenResponseDTO?
}

extension DependencyValues {
  public var authAPIClient: AuthAPIClient {
    get { self[AuthAPIClient.self] }
    set { self[AuthAPIClient.self] = newValue }
  }
}

extension AuthAPIClient: TestDependencyKey {
  public static let previewValue = Self()
  public static let testValue = Self()
}
