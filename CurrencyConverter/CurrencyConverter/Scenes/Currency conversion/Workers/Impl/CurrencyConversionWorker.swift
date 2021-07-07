//
//  CurrencyConversionWorker.swift
//  CurrencyConverter
//
//  Created by Tiago Chaves on 11/02/20.
//  Copyright © 2020 Tiago Chaves. All rights reserved.
//

import Foundation

struct CurrencyConversionWorker: CurrencyConversionWorkerProtocol {
    
    func convert(_ value: Double, currency sourceDolarQuote: USDCurrencyQuote, to resultDolarQuote: USDCurrencyQuote) -> Double {
        let conversionRate = sourceDolarQuote.dolarQuote / resultDolarQuote.dolarQuote
        return value * conversionRate
    }
}
