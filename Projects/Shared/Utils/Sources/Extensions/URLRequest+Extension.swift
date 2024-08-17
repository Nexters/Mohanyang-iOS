//
//  URLRequest+Extension.swift
//  Utils
//
//  Created by 김지현 on 8/17/24.
//  Copyright © 2024 PomoNyang. All rights reserved.
//

import Foundation

public extension URLRequest {
  func asRequestLog() -> String {
    let log = """
  🛰 NETWORK Request LOG
   URL: \(self.url?.absoluteString ?? "")
   Method: \(self.httpMethod ?? "")
   Authorization: \(self.value(forHTTPHeaderField: "Authorization") ?? "")
   Body: \(self.httpBody?.toPrettyPrintedString ?? "")
  """
    return log
  }

  func asResponseLog(_ data: Data, _ response: HTTPURLResponse) -> String {
    let log = """
  🛰 NETWORK Response LOG
   URL: \(self.url?.absoluteString ?? "")
   StatusCode: \(response.statusCode)
   Data: \(data.toPrettyPrintedString ?? "")
  """
    return log
  }
}
