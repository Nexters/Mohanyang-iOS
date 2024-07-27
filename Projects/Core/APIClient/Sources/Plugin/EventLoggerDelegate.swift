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
  func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
    if let error = error {
      print("🛰 NETWORK Request Error: \(error.localizedDescription)")
    } else {
      print("🛰 NETWORK Request Completed Successfully")
    }

    if let request = task.originalRequest {
      print("🛰 NETWORK Request LOG")
      print(request.description)
      print("URL: " + (request.url?.absoluteString ?? ""))
      print("Method: " + (request.httpMethod ?? ""))
      if let body = request.httpBody {
        print("Body: " + (body.toPrettyPrintedString ?? ""))
      }
    }

    if let response = task.response as? HTTPURLResponse {
      print("🛰 NETWORK Response LOG")
      print("StatusCode: \(response.statusCode)")
      if let data = try? Data(contentsOf: response.url!) {
        print("Data: \(data.toPrettyPrintedString ?? "")")
      }
    }
  }
}
