//
//  EventLoggerDelegate.swift
//  APIClientInterface
//
//  Created by 김지현 on 7/24/24.
//  Copyright © 2024 PomoNyang. All rights reserved.
//

import Foundation
import Shared

class EventLoggerDelegate: NSObject, URLSessionDelegate, URLSessionTaskDelegate, URLSessionDataDelegate {
  func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive data: Data) {
    // MARK: CAT-98 - 로그 안찍힘
    print("~~~~~~~~~~~~", data.toPrettyPrintedString)
  }

  func urlSession(_ session: URLSession, task: URLSessionTask, didFinishCollecting metrics: URLSessionTaskMetrics) {
    if let request = task.originalRequest {
      print("🛰 NETWORK Request LOG")

      print("URL: " + (request.url?.absoluteString ?? ""))
      print("Method: " + (request.httpMethod ?? ""))
      if let body = request.httpBody {
        print("Body: " + (body.toPrettyPrintedString ?? ""))
      }
    }

    if let response = task.response as? HTTPURLResponse {
      print("🛰 NETWORK Response LOG")
      print("StatusCode: \(response.statusCode)")
    }
  }
}
