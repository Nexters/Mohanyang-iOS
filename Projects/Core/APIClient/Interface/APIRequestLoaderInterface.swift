//
//  NetworkProvider.swift
//  APIClientInterface
//
//  Created by 김지현 on 7/24/24.
//  Copyright © 2024 PomoNyang. All rights reserved.
//

import Foundation

public protocol APIRequestLoaderInterface {
  func fetchData<M: Decodable> (
    target: TargetType,
    responseData: M.Type
  ) async throws -> M
}
