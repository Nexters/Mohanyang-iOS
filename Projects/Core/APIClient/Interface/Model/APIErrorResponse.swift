//
//  APIErrorResponse.swift
//  APIClientInterface
//
//  Created by 김지현 on 4/10/25.
//  Copyright © 2025 PomoNyang. All rights reserved.
//

import Foundation

public struct APIErrorResponse: Decodable, Error {
  public let type: String
  public let message: String
  public let errorTraceId: String
}
