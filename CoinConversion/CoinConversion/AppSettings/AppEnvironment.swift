//
//  AppEnvironment.swift
//  CoinConversion
//
//  Created by Ronilson Batista on 18/07/20.
//  Copyright © 2020 Ronilson Batista. All rights reserved.
//

enum AppEnvironment {
    case domain
    case listCurrencies
    case quotes
    
    var value: String {
        switch self {
        case .domain: return "http://api.currencylayer.com/"
        case .listCurrencies: return "list"
        case .quotes: return "live"
        }
    }
}
