//
//  Utils.swift
//  BTGChallenge
//
//  Created by Gerson Vieira on 16/06/20.
//  Copyright © 2020 Gerson Vieira. All rights reserved.
//

import UIKit

class Utils {
    static let shared = Utils()
    
    
    func convertFinalValue(quotes: [CurrencyLiveViewData], fromCurrency: String, toCurrency: String, amount: String) -> String {
        let dolar = self.convertValueToDollar(quotes: quotes, fromCurrency: fromCurrency, amount: amount)
        let finalValue = self.finalValue(quotes: quotes, toCurrency: toCurrency, valueDollar: dolar)
        return String(format: "%.2f", finalValue)
    }
    
    
    private func convertValueToDollar(quotes: [CurrencyLiveViewData], fromCurrency: String, amount: String) -> Double {
        let currencyFrom = getCodeFromCurrency(text: fromCurrency)
        for element in quotes {
            if currencyFrom == element.currencyCode {
                let convert = amount.double / element.CurrencyQuote
                return convert
            }
        }
        return 0.0
    }
    
    private func finalValue(quotes: [CurrencyLiveViewData], toCurrency: String, valueDollar: Double) -> Double {
        
        let currencyTo = getCodeFromCurrency(text: toCurrency)
        
        if currencyTo == "USDUSD" {
            return valueDollar
        } else {
            for element in quotes {
                if currencyTo == element.currencyCode {
                    let finalValue = valueDollar * element.CurrencyQuote
                    return  finalValue
                }
            }
        }
        return 0.0
    }
    
    private func getCodeFromCurrency(text: String) -> String {
        let currencyCode = String(text.prefix(3))
        let code = "USD\(currencyCode)"
        return code
    }
}
