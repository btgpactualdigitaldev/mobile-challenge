//
//  CurrencyResponse.swift
//  BTGPactualTest
//
//  Created by Vinicius Custodio on 17/06/20.
//  Copyright © 2020 Vinicius Custodio. All rights reserved.
//

import Foundation

struct CurrencyResponse: Decodable {
    let success: Bool
    let currencies: [String:String]
    
    func getCurrencies() -> [Currency] {
        var currencies = [Currency]()
        
        for (key, value) in self.currencies {
            currencies.append(Currency(code: key, name: value))
        }
        
        return currencies
    }
}

class Currency {
    var name: String
    var code: String
    var filter: String
    
    init(code: String, name: String) {
        self.code = code
        self.name = name
        
        self.filter = "\(self.code) \(self.name)".uppercased()
    }
    
    var quoteKey: String {
        return "USD\(self.code)"
    }
}
