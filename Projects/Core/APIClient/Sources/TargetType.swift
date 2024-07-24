//
//  TargetType.swift
//  APIClientInterface
//
//  Created by 김지현 on 7/23/24.
//  Copyright © 2024 PomoNyang. All rights reserved.
//

import Foundation
import APIClientInterface
import KeychainClientInterface
import Shared


extension TargetType {
    public func asURLRequest(keychainClient: KeychainClient) async throws -> URLRequest {
        let url = URL(string: baseURL)!
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        urlRequest.httpMethod = method.rawValue
        urlRequest.setValue(
            contentType.rawValue,
            forHTTPHeaderField: HTTPHeaderField.contentType.rawValue
        )
        if let jwt = keychainClient.read(key: "jwt") {
            urlRequest.addValue(
                jwt,
                forHTTPHeaderField: HTTPHeaderField.authentication.rawValue
            )
        }

        switch parameters {
        case .query(let request):
            let params = try request.toDictionary()
            let queryParams = params.map { URLQueryItem(name: $0.key, value: "\($0.value)") }
            var components = URLComponents(string: url.appendingPathComponent(path).absoluteString)
            components?.queryItems = queryParams
            urlRequest.url = components?.url

        case .body(let request):
            if let requestArray = request as? [AnyObject] {
                var arrayParams: [[String: Any]] = []
                try requestArray.forEach {
                    if let value = $0 as? Encodable {
                        let param = try value.toDictionary()
                        arrayParams.append(param)
                    }
                }
                urlRequest.httpBody = try? JSONSerialization.data(withJSONObject: arrayParams, options: [])
            } else {
                let params = try request.toDictionary()
                urlRequest.httpBody = try? JSONSerialization.data(withJSONObject: params, options: [])
            }
        case .requestPlain:
            break
        }
        return urlRequest
    }
}

public extension TargetType {
    var contentType: ContentType {
        return .json
    }
}
