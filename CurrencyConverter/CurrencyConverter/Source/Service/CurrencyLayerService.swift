//
//  CurrencyLayerService.swift
//  CurrencyConverter
//
//  Created by Italo Boss on 13/12/20.
//

import Foundation

enum CurrencyLayerService: Service {
    
    case list
    case live(from: String, to: String)
    
    var baseURL: URL {
        guard let url = URL(string: "http://api.currencylayer.com")
            else {
                return URL(fileURLWithPath: "")
        }
        return url
    }
    
    var path: String {
        switch self {
        case .list:
            return "/list"
        case .live:
            return "/live"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .list, .live:
            return .get
        }
    }
    
    var task: HTTPTask {
        switch self {
        case .list:
            return .requestParameters(["access_key": accessKey])
        case .live(let fromCurrency, let toCurrency):
            return .requestParameters(["access_key": accessKey, "currencies": "\(fromCurrency),\(toCurrency)"])
        }
    }
    
    var headers: Headers? {
        switch self {
        case .list, .live:
            return ["Accept": "application/json"]
        }
    }
    
    var parametersEncoding: ParametersEncoding {
        switch self {
        case .list, .live:
            return .url
        }
    }
    
    // MARK: - API Access Key
    var accessKey: String {
        return "d8b189f5cf89be26d1ac7d1f2dad1251"
    }
    
}
