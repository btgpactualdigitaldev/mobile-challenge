import Foundation
import Domain

class ListQuotesSpy: ListQuotes {
    var completion: ((ListQuotes.Result) -> Void)?

    func list(completion: @escaping (ListQuotes.Result) -> Void) {
        self.completion = completion
    }

    func completedWithError(_ error: DomainError) {
        completion?(.failure(error))
    }
    
    func completedWithData(_ quotes: QuotesModel) {
        completion?(.success(quotes))
    }
}
