//
//  EndpointCurrencyLayer.swift
//  Coin Converter
//
//  Created by Andre Casarini on 18/08/20.
//  Copyright © 2020 Andre Casarini. All rights reserved.
//

import Foundation

struct Endpoint {
    
    private enum CurrencyLayerComponents {
        
        static let scheme = "http"
        
        static var host: String {
            return "api.currencylayer.com"
        }
        
        static func baseURL() -> URL {
            var components: URLComponents = URLComponents()
            components.scheme = scheme
            components.host = host
            
            return components.url!
        }
    }
    
    enum CurrencyLayer: Requestable {
        case list
        case live
        
        static let accessToken: String = "6605cbcb0d318664f31ec51d49924943"
        
        var url: URL {
            switch self {
            case .list:
                var url: URL = CurrencyLayerComponents.baseURL()
                url.appendPathComponent("/list")
                return url
            case .live:
                var url: URL = CurrencyLayerComponents.baseURL()
                url.appendPathComponent("/live")
                return url
            }
        }
        
        var method: HTTPMethod {
            return .get
        }
        
        var headers: [String: String] {
            return [:]
        }
        
        var parameters: [String: String] {
            return ["access_key": Endpoint.CurrencyLayer.accessToken]
        }
        
        var customBody: Data? {
            return nil
        }
    }
}
