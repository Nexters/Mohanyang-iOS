import Foundation

// MARK: StreamType

public protocol StreamTypeProtocol: Hashable {
  static var key: StreamType { get }
}

public enum StreamType: Hashable {
  case serverState
  case retry
  case toast
}

public enum ServerState: StreamTypeProtocol {
  public static var key: StreamType { .serverState }
  case requestStarted
  case requestCompleted
  case errorOccured
  case networkDisabled
}
