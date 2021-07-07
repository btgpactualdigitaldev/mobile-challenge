//
//  USDCurrencyQuote.swift
//  CurrencyConverter
//
//  Created by Tiago Chaves on 10/02/20.
//  Copyright © 2020 Tiago Chaves. All rights reserved.
//

import Foundation

struct USDCurrencyQuote: Equatable {
    let currencyInitials: String
    let quote: Double
    
    var dolarQuote: Double {
        return 1/quote
    }
}
