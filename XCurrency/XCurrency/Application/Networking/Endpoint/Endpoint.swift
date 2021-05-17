//
//  Endpoint.swift
//  XCurrency
//
//  Created by Vinicius Nadin on 29/03/21.
//

import Foundation

enum Endpoint {
    case currencies, currencyRate
}

// MARK: - Endpoint Implementation
extension Endpoint: RequestProviding {

    // MARK: - Attributes
    private var baseURL: String { return "http://api.currencylayer.com" }
    private var key: String { return "9b1e44195ac89bcf7933647226ac1bc5" }

    var urlRequest: URLRequest {
        switch self {
        case .currencies:
            let stringURL: String = "\(self.baseURL)/list?access_key=\(self.key)"
            if let currenciesURL: URL = URL(string: stringURL) {
                return URLRequest(url: currenciesURL)
            }
            preconditionFailure("FAILURE")
        case .currencyRate:
            let stringURL: String = "\(self.baseURL)/live?access_key=\(self.key)"
            if let currenciesURL: URL = URL(string: stringURL) {
                return URLRequest(url: currenciesURL)
            }
            preconditionFailure("FAILURE")
        }
    }
}
