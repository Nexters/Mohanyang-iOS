import Foundation

public class StreamContinuation {
  private let _yield: (any StreamType) -> Void
  private let _finish: () -> Void

  public init<T: StreamType>(_ continuation: AsyncStream<T>.Continuation) {
    self._yield = { value in
      guard let value = value as? T else { return }
      continuation.yield(value)
    }

    self._finish = {
      continuation.finish()
    }
  }

  public func yield(_ value: any StreamType) {
    _yield(value)
  }

  public func finish() {
    _finish()
  }
}
