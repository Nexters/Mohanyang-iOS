//
//  KeychainClientTesting.swift
//  KeychainClient
//
//  Created by devMinseok on 7/20/24.
//  Copyright © 2024 PomoNyang. All rights reserved.
//

import KeychainClientInterface

import Dependencies

extension KeychainClient {
  public static let mock = Self(
    create: { _, _ in
      return true
    },
    read: { value in
      return value
    },
    update: { _, _ in
      return true
    },
    delete: { _ in
      return true
    },
    deleteAll: {
    }
  )
}
