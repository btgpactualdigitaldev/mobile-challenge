//
//  Endpoint.swift
//  mobile-challenge-UIKit
//
//  Created by Lucas Fernandez Nicolau on 16/12/20.
//

import Foundation

enum Endpoint {
    case currencyList
    case currencyLiveRate
}

extension Endpoint: URLRequestProviding {

    // Ideally, this would not be pushed into the GitHub repo
    private var apiKey: String {
        return "0e087dc1484d5ca52892c94ea91d6e24"
    }

    private var baseURL: String {
        return "http://api.currencylayer.com"
    }

    var urlRequest: URLRequest {
        switch self {
        case .currencyList:
            guard let url = URL(string: "\(baseURL)/list?access_key=\(apiKey)") else {
                preconditionFailure(NetworkingError.invalidURL.rawValue)
            }

            return URLRequest(url: url)
            
        case .currencyLiveRate:
            guard let url = URL(string: "\(baseURL)/live?access_key=\(apiKey)") else {
                preconditionFailure(NetworkingError.invalidURL.rawValue)
            }

            return URLRequest(url: url)
        }
    }
}
