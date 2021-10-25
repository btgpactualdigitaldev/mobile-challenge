//
//  BTGCurrencyProvider.swift
//  ChallengerConverter
//
//  Created by ADRIANO.MAZUCATO on 23/10/21.
//

import Foundation


enum HTTPMethod: String {
    case GET
    case POST
}


protocol Provider {
    var endpoint: String { get }
    var method: HTTPMethod { get }
}

fileprivate class Constants {
    static let baseURL = "http://api.currencylayer.com/"
    static let accessKey: String = "?access_key=6e0f2a31e5403643184897362ce49c94"
}

enum ApiProvider: Provider {
    
    case live
    case list
    
    var endpoint: String {
        switch(self) {
        case .list:
            return "\(Constants.baseURL)list\(Constants.accessKey)"
        case .live:
            return "\(Constants.baseURL)live\(Constants.accessKey)"
        }
    }
    
    var method: HTTPMethod {
        return .GET
    }
}
