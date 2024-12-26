import Foundation

public protocol StreamElement: Hashable { }

public class StreamContinuation {
  private let _yield: (any StreamType) -> Void

  public init<T: StreamType>(_ continuation: AsyncStream<T>.Continuation) {
    self._yield = { value in
      guard let value = value as? T else { return }
      continuation.yield(value)
    }
  }

  public func yield(_ value: any StreamType) {
    _yield(value)
  }
}
