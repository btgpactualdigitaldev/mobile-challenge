//
//  URLSessionDataTaskProtocol.swift
//  CurrencyExchange
//
//  Created by Carlos Fontes on 31/10/20.
//

import Foundation

protocol URLSessionDataTaskProtocol {
    func resume()
    func cancel()
}

extension URLSessionDataTaskProtocol {
    func resume() {}
    func cancel() {}

}
extension URLSessionDataTask: URLSessionDataTaskProtocol{}


