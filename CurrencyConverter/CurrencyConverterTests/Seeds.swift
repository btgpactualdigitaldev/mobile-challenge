//
//  Seeds.swift
//  CurrencyConverterTests
//
//  Created by Tiago Chaves on 10/02/20.
//  Copyright © 2020 Tiago Chaves. All rights reserved.
//
@testable import CurrencyConverter
import Foundation

struct Seeds {
    
    struct APISeeds {
        static let supportedCurrencies = SupportedCurrencies(success: true, currencies: ["USD":"United States Dollar",
                                                                                         "BRL":"Brazilian Real",
                                                                                         "ANG":"Netherlands Antillean Guilder",
                                                                                         "BGN":"Bulgarian Lev"])
        
        static let supportedCurrenciesAPIError = SupportedCurrencies(success: false, currencies: [:])
        
        static let exchangeRates = ExchangeRates(success: true, source: "USD", timestamp: 123456789, quotes: ["USDBRL":4.0,
                                                                                                               "USDUSD":1])
        static let exchangeRatesAPIError = ExchangeRates(success: false, source: "USD", timestamp: 123456789, quotes: ["USDBRL":4.0,
                                                                                                                        "USDUSD":1])
    }
    
    struct ViewModels {
        static var viewModelCurrencies = [Currency(initials: "USD", name: "United States Dollar"),
                                          Currency(initials: "BRL", name: "Brazilian Real"),
                                          Currency(initials: "ANG", name: "Netherlands Antillean Guilder"),
                                          Currency(initials: "BGN", name: "Bulgarian Lev")]
    }
}
