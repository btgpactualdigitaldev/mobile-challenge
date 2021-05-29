//
//  ExchangeViewModel.swift
//  mobile-challenge
//
//  Created by Bernardo Nunes on 22/11/20.
//

import Foundation

class ExchangeViewModel {
    
    var fromCurrency: CurrencyModel?
    var toCurrency: CurrencyModel?
    
    func convertCurrencies(value: String) throws -> String {
        guard let value = Double(value) else { throw ExchangeError.emptyValue }
        guard let fromValue = fromCurrency?.value else { throw ExchangeError.emptyFrom }
        guard let toValue = toCurrency?.value else { throw ExchangeError.emptyTo }
        
        let dollarValue = fromValue/value
        let finalValue = toValue/dollarValue
        
        return String(format: "%.2f", finalValue)
    }
}
