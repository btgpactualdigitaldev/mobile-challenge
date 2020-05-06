//
//  StaticRequester.swift
//  Networking
//
//  Created by Gustavo Amaral on 05/05/20.
//  Copyright © 2020 Gustavo Almeida Amaral. All rights reserved.
//

import Foundation
import Combine
import Models
import Networking

class StaticRequester: Requester {
    
    func request(at url: URL, method: HTTPMethod, headers: [String : String], queryParameters: [String : Any], body: Data?) -> AnyPublisher<RequestResponse, RequestError> {
        switch url.absoluteString {
        case "http://apilayer.net/api/live":
            return realTimeRatesResponse()
        case "http://apilayer.net/api/list":
            return supportedCurrenciesResponse()
        default:
            fatalError("Unsupported URL")
        }
    }
}

fileprivate func supportedCurrenciesResponse(_ bundle: Bundle = .main) -> AnyPublisher<RequestResponse, RequestError> {
    let url = bundle.url(forResource: "supported_currencies", withExtension: "txt")!
    let data = try! Data(contentsOf: url)
    return Just(RequestResponse.init(data: data, status: .ok, request: URLRequest(url: url)))
        .setFailureType(to: RequestError.self)
        .eraseToAnyPublisher()
}

fileprivate func realTimeRatesResponse(_ bundle: Bundle = .main) -> AnyPublisher<RequestResponse, RequestError> {
    let url = bundle.url(forResource: "real_time_rates", withExtension: "txt")!
    let data = try! Data(contentsOf: url)
    return Just(RequestResponse.init(data: data, status: .ok, request: URLRequest(url: url)))
        .setFailureType(to: RequestError.self)
        .eraseToAnyPublisher()
}
