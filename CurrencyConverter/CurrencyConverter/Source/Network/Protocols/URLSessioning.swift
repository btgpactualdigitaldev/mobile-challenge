//
//  URLSessioning.swift
//  CurrencyConverter
//
//  Created by Italo Boss on 15/12/20.
//

import Foundation

public protocol URLSessioning {
    
    /// DataTask with a completion using Result
    ///
    /// - Parameters:
    ///   - url: expect some url as value
    ///   - result: completion using Result
    /// - Returns: URLSessionDataTask
    func dataTask(
        with url: URLRequest,
        result: @escaping (Result<(URLResponse, Data), Error>) -> Void
    ) -> URLSessionDataTask
    
}
