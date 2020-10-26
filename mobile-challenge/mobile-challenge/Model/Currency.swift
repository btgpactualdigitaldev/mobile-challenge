//
//  Currency.swift
//  mobile-challenge
//
//  Created by Matheus Brasilio on 25/10/20.
//  Copyright © 2020 Matheus Brasilio. All rights reserved.
//

import Foundation

public class Currency {
    public var symbol: String
    public var name: String
    
    init(symbol: String, name: String) {
        self.symbol = symbol
        self.name = name
    }
}

public struct CurrencyDollarValue {
    public var symbol: String
    public var dollarQuotation: Double
    
    init(symbol: String, dollarQuotation: Double) {
        self.symbol = symbol
        self.dollarQuotation = dollarQuotation
    }
}
