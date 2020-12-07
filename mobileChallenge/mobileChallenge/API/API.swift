//
//  API.swift
//  mobileChallenge
//
//  Created by Renato Carvalhan on 01/12/20.
//  Copyright © 2020 Renato Carvalhan. All rights reserved.
//

import Foundation
import Combine

enum ServiceError: Error {
    case unexpected
    case parsingError
}

struct Environment {
    static var baseURL: String {
        return "http://api.currencylayer.com/"
    }

    static var accessKey: String {
        return "?access_key=7787f5623cd1653ff167db4f9c441026"
    }
}

final class Api {
    
    private enum Endpoint: String {
        case list = "list"
        case live = "live"
    }
    
    private init() {}
    static let shared = Api()
    
    func lists() -> AnyPublisher<ListCurrency, ServiceError> {
        handle(.list)
    }
    
    func lives() -> AnyPublisher<LiveCurrency, ServiceError> {
        handle(.live)
    }
    
    private func handle<T: Codable>(_ endPoint: Endpoint) -> AnyPublisher<T, ServiceError> {
        let urlRequest = request(endPoint)
        return URLSession.shared.dataTaskPublisher(for: urlRequest)
            .mapError{ _ in ServiceError.unexpected }
            .map { $0.data }
            .decode(type: T.self, decoder: JSONDecoder())
            .mapError { _ in ServiceError.parsingError }
            .eraseToAnyPublisher()
    }
    
    private func request(_ endpoint: Endpoint) -> URLRequest {
        let path = "\(Environment.baseURL)\(endpoint.rawValue)\(Environment.accessKey)"
        guard let url = URL(string: path)
            else { preconditionFailure("Error ===== bad URL") }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = ["Content-Type": "application/json"]
        return request
    }
}
