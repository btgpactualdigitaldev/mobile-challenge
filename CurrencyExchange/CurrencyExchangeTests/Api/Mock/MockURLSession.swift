//
//  MockURLSession.swift
//  CurrencyExchangeTests
//
//  Created by Carlos Fontes on 31/10/20.
//

import Foundation
@testable import CurrencyExchange


class MockURLSession: URLSessionProtocol {
    
    var dataTask = MockURLSessionDataTask()
    var data: Data?
    var error: Error?
    
    private(set) var lastURL: URL?
    
    func successHttpURLResponse(request: URLRequest) -> URLResponse {
           return HTTPURLResponse(url: request.url!, statusCode: 200, httpVersion: "HTTP/1.1", headerFields: nil)!
    }
    
    func dataTaskWithRequest(_ request: URLRequest, completionHandler: @escaping DataTaskResult) -> URLSessionDataTaskProtocol {
        
        lastURL = request.url
        
        completionHandler(data, successHttpURLResponse(request: request), error)
        return dataTask
    }
    
    
}
