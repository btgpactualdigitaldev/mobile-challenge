//
//  CurrencyQuotes.swift
//  currency-converter
//
//  Created by Rodrigo Queiroz on 09/10/20.
//

import Foundation

class CurrencyQuotes: NSObject {
    
    var cod: String
    var amount: Float
    
    init(_ cod:String, _ amount: Float) {
        self.cod = cod
        self.amount = amount
        
    }
    
}
