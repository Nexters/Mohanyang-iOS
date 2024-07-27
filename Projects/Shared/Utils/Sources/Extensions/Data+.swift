//
//  Data.swift
//  Utils
//
//  Created by 김지현 on 7/24/24.
//  Copyright © 2024 PomoNyang. All rights reserved.
//

import Foundation

extension Data {
  public var toPrettyPrintedString: String? {
    guard let json = try? JSONSerialization.jsonObject(with: self, options: []),
          let data = try? JSONSerialization.data(withJSONObject: json, options: [.prettyPrinted]),
          let prettyPrintedString = String(data: data, encoding: .utf8) else { return nil }
    return prettyPrintedString
  }
}
