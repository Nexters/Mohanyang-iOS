//
//  HTTPMethod.swift
//  APIClientInterface
//
//  Created by 김지현 on 7/23/24.
//  Copyright © 2024 PomoNyang. All rights reserved.
//

import Foundation

public struct HTTPMethod: RawRepresentable, Equatable, Hashable {
    public static let post = HTTPMethod(rawValue: "POST")
    public static let get = HTTPMethod(rawValue: "GET")
    public static let put = HTTPMethod(rawValue: "PUT")
    public static let patch = HTTPMethod(rawValue: "PATCH")
    public static let delete = HTTPMethod(rawValue: "DELETE")

    public let rawValue: String

    public init(rawValue: String) {
        self.rawValue = rawValue
    }
}
