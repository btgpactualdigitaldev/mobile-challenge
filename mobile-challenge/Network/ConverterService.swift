//
//  ConverterService.swift
//  mobile-challenge
//
//  Created by Murilo Teixeira on 26/09/20.
//

import Foundation

enum ConverterService {
    case currencyList
    case liveConverter
}

extension ConverterService: ServiceProtocol {
    var path: String {
        switch self {
        case .currencyList:
            return makeUrl("list")
        case .liveConverter:
            return makeUrl("live")
        }
    }
    
    var method: HttpMethod {
        .get
    }
    
    private func makeUrl(_ route: String) -> String {
        let url = "http://api.currencylayer.com"
        let apiKey = "access_key=98d190b4ad2ecb4e667cdb821797d622"
        return "\(url)/\(route)?\(apiKey)"
    }
}
