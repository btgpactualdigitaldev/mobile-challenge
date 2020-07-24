//
//  Currencies.swift
//  BTGCurrencyConverter
//
//  Created by Ian McDonald on 22/07/20.
//  Copyright © 2020 Ian McDonald. All rights reserved.
//

import Foundation

class Currencies: Codable {
    let list: [Currency]
    var lastUpdate: Date
    var isValid: Bool {
        return Date(timeInterval: 86400, since: lastUpdate) > Date()
    }
    
    init(supportedCurrencies: SupportedCurrencies) {
        var currencyList = [Currency]()
        for currency in supportedCurrencies.currencies {
            currencyList.append(Currency(name: currency.value, symbol: currency.key))
        }
        list = currencyList.sorted{ $0.name.lowercased() < $1.name.lowercased() }
        lastUpdate = Date()
    }
}
