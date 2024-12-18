import Foundation

public class AnyStreamContinuation {
    private let _yield: (Any) -> Void
    
    public init<T>(_ continuation: AsyncStream<T>.Continuation) {
        self._yield = { value in
            guard let value = value as? T else { return }
            continuation.yield(value)
        }
    }
    
    public func yield(_ value: Any) {
        _yield(value)
    }
}
