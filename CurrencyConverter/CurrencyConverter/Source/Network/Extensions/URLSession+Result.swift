//
//  URLSession+Result.swift
//  CurrencyConverter
//
//  Created by Italo Boss on 13/12/20.
//

import Foundation

extension URLSession: URLSessioning {

    /// DataTask with a completion using Result
    ///
    /// - Parameters:
    ///   - url: expect some url as value
    ///   - result: completion using Result
    /// - Returns: URLSessionDataTask
    public func dataTask(
        with url: URLRequest,
        result: @escaping (Result<(URLResponse, Data), Error>) -> Void) -> URLSessionDataTask {

        return dataTask(with: url) { (data, response, error) in
            if let error = error {
                result(.failure(error))
                return
            }
            guard let response = response, let data = data else {
                let error = NSError(domain: "error", code: 0, userInfo: nil)
                result(.failure(error))
                return
            }
            result(.success((response, data)))
        }
    }
    
}
