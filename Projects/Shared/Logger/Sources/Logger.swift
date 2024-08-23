//
//  Logger.swift
//  Logger
//
//  Created by devMinseok on 7/19/24.
//  Copyright © 2024 PomoNyang. All rights reserved.
//

import OSLog

public enum LogCategory: String {
  case network = "Network"
  case ui = "UI"
  case database = "Database"
  case analytics = "Analytics"
  case performance = "Performance"
  case etc = "ETC"
  case web = "WEB"
}

public final class Logger {
  public static let shared = Logger()
  
  public private(set) var logs: [String] = []
  
  private init() {}
  
#if DEBUG
  private let appIdentifier = Bundle.main.bundleIdentifier ?? "???"
  private let logsAccessQueue = DispatchQueue(label: "com.logger.logsAccessQueue", attributes: .concurrent)
  
  private func logger(category: LogCategory) -> os.Logger {
    return os.Logger(subsystem: appIdentifier, category: category.rawValue)
  }
  
  public func log(level: OSLogType = .default, category: LogCategory = .etc, _ string: @autoclosure () -> String) {
    let logMessage = string()
    if ProcessInfo.processInfo.environment["XCODE_RUNNING_FOR_PREVIEWS"] == "1" {
      print("\(logMessage)")
    } else {
      self.logger(category: category).log(level: level, "\(logMessage)")
    }
    appendLog(logMessage)
  }
  
  public func clear() {
    logsAccessQueue.async(flags: .barrier) {
      self.logs = []
    }
  }
  
  private func appendLog(_ logMessage: String) {
    logsAccessQueue.async(flags: .barrier) {
      self.logs.append(logMessage)
    }
  }
#else
  @inlinable @inline(__always)
  public func log(level: OSLogType = .default, category: LogCategory = .etc, _ string: @autoclosure () -> String) {}
  
  @inlinable @inline(__always)
  public func clear() {}
#endif
}
