import Foundation
import Domain

public final class MainQueueDipatchDecorator<T> {
    private let instance: T
    
    public init(_ instance: T) {
        self.instance = instance
    }
    
    func dispatch(completion: @escaping () -> Void) {
        guard Thread.isMainThread else { return DispatchQueue.main.async(execute: completion) }
        completion()
    }
}

extension MainQueueDipatchDecorator: ListQuotes where T: ListQuotes {
    public func list(completion: @escaping (ListQuotes.Result) -> Void) {
        instance.list { [weak self] result in
            self?.dispatch {
                completion(result)
            }
        }
    }
}
