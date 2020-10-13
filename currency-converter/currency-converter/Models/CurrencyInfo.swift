//
//  CurrencyInfo.swift
//  currency-converter
//
//  Created by Rodrigo Queiroz on 09/10/20.
//

import Foundation

class CurrencyInfo: NSObject {
    
    var initial: String
    var fullName: String
    var currencyType: Constants.CurrencyType?
    
    init(_ initial: String, _ country: String) {
        self.fullName = country
        self.initial = initial
    }
    
    
}
