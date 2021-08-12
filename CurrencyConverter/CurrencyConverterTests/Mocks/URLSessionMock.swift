//
//  URLSessionMock.swift
//  CurrencyConverterTests
//
//  Created by Italo Boss on 15/12/20.
//

import Foundation
@testable import CurrencyConverter

final class URLSessionMock: URLSessioning {
    
    var json: String?
    var shouldFail: Bool = false
    
    func dataTask(with url: URLRequest, result: @escaping (Result<(URLResponse, Data), Error>) -> Void) -> URLSessionDataTask {
        
        if shouldFail {
            result(.failure(NetworkError.internalError))
            return URLSessionDataTaskMock()
        }
        
        guard let urlResponse = HTTPURLResponse(url: url.url!, statusCode: 200, httpVersion: nil, headerFields: nil) else {
            result(.failure(NetworkError.internalError))
            return URLSessionDataTaskMock()
        }

        guard
            let json = json,
            let data = json.data(using: .utf8)
        else {
            result(.failure(NetworkError.noJSONData))
            return URLSessionDataTaskMock()
        }

        result(.success((urlResponse, data)))
        return URLSessionDataTaskMock()
    }
    
}
