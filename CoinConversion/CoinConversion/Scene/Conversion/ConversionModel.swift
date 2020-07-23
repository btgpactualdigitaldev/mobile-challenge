//
//  ConversionModel.swift
//  CoinConversion
//
//  Created by Ronilson Batista on 22/07/20.
//  Copyright © 2020 Ronilson Batista. All rights reserved.
//

import Foundation

// MARK: - ConversionModel
class ConversionModel: NSObject {
    var date: Double?
    var conversion: [ConversionCurrenciesModel]?
    
    init(date: Double, conversion: [ConversionCurrenciesModel]) {
        self.date = date
        self.conversion = conversion
    }
}

// MARK: - ConversionCurrenciesModel
class ConversionCurrenciesModel: NSObject {
    var code: String?
    var quotes: Double?
    
    init(code: String, quotes: Double) {
        self.code = code
        self.quotes = quotes
    }
}
