//
//  CurrencyConversionWorkerMock.swift
//  CurrencyConverterTests
//
//  Created by Tiago Chaves on 11/02/20.
//  Copyright © 2020 Tiago Chaves. All rights reserved.
//
@testable import CurrencyConverter
import Foundation

struct CurrencyConversionWorkerMock: CurrencyConversionWorkerProtocol {
    var returnValue: Double = 1.0
    
    func convert(_ value: Double, currency sourceDolarQuote: USDCurrencyQuote, to resultDolarQuote: USDCurrencyQuote) -> Double {
        return returnValue
    }
}
