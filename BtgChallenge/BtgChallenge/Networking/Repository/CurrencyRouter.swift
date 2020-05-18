//
//  CurrencyRouter.swift
//  BtgChallenge
//
//  Created by Felipe Alexander Silva Melo on 12/05/20.
//  Copyright © 2020 Felipe Alexander Silva Melo. All rights reserved.
//

import Foundation

enum CurrencyRouter {
    case live(String, String)
    case convert(String, String, String)
    case list
}

extension CurrencyRouter: HTTPRouter {
    var baseUrl: URL {
        return URL(string: Constants.Networking.baseUrl)! // swiftlint:disable:this force_unwrapping
    }
    
    var path: String {
        switch self {
        case .live:
            return "/live"
        case .convert:
            return "/convert"
        case .list:
            return "/list"
        }
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var parameters: [String: String] {
        switch self {
        case let .live(currencies, source):
            return [
                "currencies": currencies,
                "source": source,
                "format": "1"
            ]
            
        case let .convert(fromCoin, toCoin, amount):
            return [
                "from": fromCoin,
                "to": toCoin,
                "amount": amount
            ]
        case .list:
            return [:]
        }
    }
    
    var headers: [String: String]? {
        return nil
    }
}
