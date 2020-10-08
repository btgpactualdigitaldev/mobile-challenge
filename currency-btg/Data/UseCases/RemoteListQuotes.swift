import Foundation
import Domain

public final class RemoteListQuotes: ListQuotes {
    private let url: URL
    private let httpClient: HttpGetClient
    private lazy var decoder = JSONDecoder()
    
    public init(url: URL, httpClient: HttpGetClient) {
        self.url = url
        self.httpClient = httpClient
    }
    
    public func list(completion: @escaping (Result<QuotesModel ,DomainError>) -> Void) {
        httpClient.get(to: url) { [weak self] result in
            guard let weakSelf = self else { return }
            switch result {
            case .success(let data):
                guard let responseData = data else {
                    return completion(.failure(.unexpected))
                }
                if let model = try? weakSelf.decoder.decode(QuotesModel.self, from: responseData) {
                    completion(.success(model))
                } else {
                    completion(.failure(.unexpected))
                }
            case .failure: completion(.failure(.unexpected))
            }
        }
    }
}
