//
//  Currency.swift
//  DesafioBTG
//
//  Created by Rodrigo Goncalves on 05/11/20.
//

import Foundation




class Currency {
    
    let success: Bool
    let terms: String
    let privacy: String
    let currencies: [CurrencyInfo]
    
    init(_ success: Bool, _ terms: String, _ privacy: String, _ currencies:[CurrencyInfo]) {
        self.success = success
        self.terms = terms
        self.privacy = privacy
        self.currencies = currencies
    }
    
}

class CurrencyInfo {
    
    let initial: String
    let fullName: String
    var currencyType: Constants.CurrencyType?
    
    init(_ initial: String, _ fullName: String) {
        self.initial = initial
        self.fullName = fullName
    }
}


