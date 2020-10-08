import Foundation

public protocol ListQuotes {
    typealias Result = Swift.Result<QuotesModel, DomainError>
    func list(completion: @escaping (Result) -> Void)
}
