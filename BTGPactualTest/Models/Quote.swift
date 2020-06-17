//
//  QuoteResponse.swift
//  BTGPactualTest
//
//  Created by Vinicius Custodio on 17/06/20.
//  Copyright © 2020 Vinicius Custodio. All rights reserved.
//

import Foundation

struct QuoteResponse: Decodable {
    let success: Bool
    let quotes: [String:Float]
    
    func getQuotes() -> [String: Quote] {
        var quotes = [String: Quote]()
        
        for (key, value) in self.quotes {
            quotes[key] = Quote(code: key, value: value)
        }
        
        return quotes
    }
}


class Quote {
    var code: String
    var value: Float
    
    init(code: String, value: Float) {
        self.code = code
        self.value = value
    }
}
