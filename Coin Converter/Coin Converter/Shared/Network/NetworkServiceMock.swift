//
//  NetworkClient+Mock.swift
//  Coin Converter
//
//  Created by Jeferson Hideaki Takumi on 29/06/20.
//  Copyright © 2020 Takumi. All rights reserved.
//

import Foundation

//*************************************************
// MARK: - DataTask
//*************************************************

protocol URLSessionDataTaskProtocol {
    func resume()
}

extension URLSessionDataTask: URLSessionDataTaskProtocol {}

class URLSessionDataTaskMock: URLSessionDataTaskProtocol {
    func resume() {
        
    }
}

//*************************************************
// MARK: - URLSession
//*************************************************

protocol URLSessionProtocol {
    func dataTask(with urlRequest: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTaskProtocol
}

extension URLSession: URLSessionProtocol {
    
    func dataTask(with urlRequest: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTaskProtocol {
        return (dataTask(with: urlRequest, completionHandler: completionHandler) as URLSessionDataTask) as URLSessionDataTaskProtocol
    }
}

class URLSessionMock: URLSessionProtocol {

    var dataTask = URLSessionDataTaskMock()
    var completionHandler: (Data?, URLResponse?, Error?)

    init(completionHandler: (Data?, URLResponse?, Error?)) {
        self.completionHandler = completionHandler
    }
    
    func dataTask(with urlRequest: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTaskProtocol {
        completionHandler(self.completionHandler.0, self.completionHandler.1, self.completionHandler.2)
        return dataTask
    }
}
