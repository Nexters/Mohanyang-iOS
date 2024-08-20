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
    guard let data = try? customEncoder.encode(self),
          let jsonData = try? JSONSerialization.jsonObject(with: data),
          let dictionaryData = jsonData as? [String: Any] else { return [:] }
    return dictionaryData
  }
  
  private var customEncoder: JSONEncoder {
    let encoder = JSONEncoder()
    encoder.dateEncodingStrategy = .custom { date, encoder in
      var container = encoder.singleValueContainer()
      let formatter = ISO8601DateFormatter()
      
      // 2023-07-26T00:00:00Z
      formatter.formatOptions = [.withInternetDateTime, .withColonSeparatorInTime]
      if let dateString = formatter.string(for: date) {
        try container.encode(dateString)
        return
      }
      
      // 2023-07-26T00:00:00.000Z
      formatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
      if let dateString = formatter.string(for: date) {
        try container.encode(dateString)
        return
      }
      
      // 2023-07-26T00:00:00
      formatter.formatOptions = [.withFullDate, .withTime, .withColonSeparatorInTime]
      if let dateString = formatter.string(for: date) {
        try container.encode(dateString)
        return
      }
      
      throw EncodingError.invalidValue(date, EncodingError.Context(codingPath: encoder.codingPath, debugDescription: "⚠️ Date encode 실패"))
    }
    return encoder
  }
}
