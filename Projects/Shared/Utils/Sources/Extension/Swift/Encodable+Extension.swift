//
//  Encodable+.swift
//  Utils
//
//  Created by 김지현 on 7/24/24.
//  Copyright © 2024 PomoNyang. All rights reserved.
//

import Foundation

extension Encodable {
  public func toDictionary() throws -> [String: Any] {
    guard let data = try? JSONEncoder().encode(self),
          let jsonData = try? JSONSerialization.jsonObject(with: data),
          let dictionaryData = jsonData as? [String: Any] else { return [:] }
    return dictionaryData
  }
}
