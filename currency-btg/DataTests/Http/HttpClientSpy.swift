import Foundation
import Data

class HttpClientSpy: HttpGetClient {
    var urls = [URL]()
    var completion: ((Result<Data?, HttpError>) -> Void)?
    
    func get(to url: URL, completion: @escaping (Result<Data?, HttpError>) -> Void) {
        self.urls.append(url)
        self.completion = completion
    }
    
    func completeWithError(_ error: HttpError) {
        self.completion?(.failure(error))
    }
    
    func completeWithData(_ data: Data) {
        self.completion?(.success(data))
    }
}
