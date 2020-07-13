//
//  CurrencyEntity.swift
//  ConverterCurrencyBTG
//
//  Created by Thiago Vaz on 05/07/20.
//  Copyright © 2020 Thiago Santos. All rights reserved.
//

import Foundation

class CurrencyEntity: NSObject {
    var name: String = ""
    var currency: String = ""
    var quotes: Decimal = .zero
    
    init(name: String, currency: String, quotes: Decimal = .zero) {
        self.name = name
        self.currency = currency
        self.quotes = quotes
    }
}
