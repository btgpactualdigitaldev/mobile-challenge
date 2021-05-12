//
//  Currency.swift
//  BTG Teste
//
//  Created by Nunes Dreyer, Tiago on 07/12/20.
//  Copyright © 2020 Nunes Dreyer, Tiago. All rights reserved.
//

import Foundation

class CurrencyList {
    var currencies: [Currency]
    var source: String
    
    init(currencies: [Currency], source: String) {
        self.currencies = currencies
        self.source = source
    }
}

class Currency {
    var name: String
    var symbol: String
    var value: Double
    
    init(name: String, symbol: String, value: Double) {
        self.name = name
        self.symbol = symbol
        self.value = value
    }
}
