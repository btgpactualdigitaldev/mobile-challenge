//
//  CurrencyList.swift
//  mobile-challenge
//
//  Created by gabriel on 29/11/20.
//

import Foundation

/**
 Model of the currency list designed from the API needed attributes.
 */
struct CurrencyList: Codable {
    let currencies: [Currency]
    
    enum CodingKeys: CodingKey {
        case currencies
    }
    
    init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        let dict = try container.decode([String:String].self, forKey: .currencies)
        currencies = dict.map({Currency(name: $0.value, symbol: $0.key)})
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        var dict = [String:String]()
        currencies.forEach({dict[$0.symbol] = $0.name})
        try container.encode(dict, forKey: .currencies)
    }
}
