//
//  Router.swift
//  Challenge
//
//  Created by Eduardo Raffi on 10/10/20.
//  Copyright © 2020 Eduardo Raffi. All rights reserved.
//

import Foundation

internal enum Router {
    case liveConversionDefault
    case liveConversionWithSource(currency: String)
    case availableList
}

extension Router {

    var scheme: String {
        return "http"
    }

    var host: String {
        return "api.currencylayer.com"
    }
    
    var path: String {
        switch self {
        case .liveConversionDefault, .liveConversionWithSource:
            return "/live"
        case .availableList:
            return "/list"
        }
    }
    
    var parameters: [URLQueryItem] {
        switch self {
        case let .liveConversionWithSource(currency):
            return [
                URLQueryItem(name: "access_key", value: "75738a294cd342dc28467fb593747d05"),
                URLQueryItem(name: "source", value: currency)
            ]
        case .liveConversionDefault, .availableList:
            return [URLQueryItem(name: "access_key", value: "75738a294cd342dc28467fb593747d05")]
        }
    }
    
    var method: String {
        return "GET"
    }

}
