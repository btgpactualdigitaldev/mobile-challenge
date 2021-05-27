//
//  CurrenciesMock.swift
//  CurrencyConverterTests
//
//  Created by Renan Santiago on 14/08/20.
//  Copyright © 2020 Renan Santiago. All rights reserved.
//

import Foundation
@testable import Currencies

class CurrenciesMock {
    var fromCurrency: CurrencyModel {
        get {
            let currencyGet = CurrencyModel()
            currencyGet.name = "BRL"
            currencyGet.nameFull = "Brazilian Real"
            currencyGet.quote = 5.3
            return currencyGet
        }
    }
    
    var toCurrency: CurrencyModel {
        get {
            let currencyGet = CurrencyModel()
            currencyGet.name = "USD"
            currencyGet.nameFull = "United States Dollar"
            currencyGet.quote = 1
            return currencyGet
        }
    }
    
    func getCurrencies() -> [CurrencyModel] {
        var currencies: [CurrencyModel] = []
        
        for _ in (0...10) {
            let currency = CurrencyModel()
            currency.name = "BRL"
            currency.nameFull = "Brazilian Real"
            currency.quote = 5.30
            currencies.append(currency)
        }
        
        return currencies
    }
}
