//
//  CurrencyRouter.swift
//  ConverterCurrencyBTG
//
//  Created by Thiago Vaz on 30/06/20.
//  Copyright © 2020 Thiago Santos. All rights reserved.
//

import Foundation

public typealias Parameters = [String: String]

protocol RequestProtocol {
    var baseUrl: String { get }
    var path: String { get }
    var accessKey: String { get }
    var method: HTTPMethod {get}
    func asURLRequest() throws -> URLRequest
    
}
enum CurrencyRouter: RequestProtocol {
    case list
    case live
    
    var accessKey: String {
        return "2594e4fbc3f8c8609f91fc8c8abf63b1"
    }
//f2954fa6f49f6af0b3fe2c631cc821a2
//2594e4fbc3f8c8609f91fc8c8abf63b1
    
    func asURLRequest() throws -> URLRequest {
        
        guard var urlComp = URLComponents(string: baseUrl) else {
            fatalError("URLComponents invalid")
        }
        
        var baseParameters: Parameters = [:]
        baseParameters["access_key"] = accessKey
        urlComp.queryItems = baseParameters.map({ URLQueryItem(name: $0.key, value: $0.value)})
        
        guard let url = urlComp.url else {
            fatalError("url invalid")
        }
        
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        urlRequest.httpMethod = method.rawValue
        return urlRequest
    }
    
    var baseUrl: String {
        return "http://api.currencylayer.com"
    }
    
    var path: String {
        switch self {
        case .list:
            return "/list"
        case .live:
            return  "/live"
        }
    }
    
    var method: HTTPMethod {
        return .get
    }
}
