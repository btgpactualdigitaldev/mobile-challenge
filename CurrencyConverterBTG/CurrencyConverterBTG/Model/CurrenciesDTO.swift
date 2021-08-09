//
//  CurrenciesDTO.swift
//  CurrencyConverterBTG
//
//  Created by Alex Nascimento on 23/03/21.
//

import Foundation

/**
  For API Documentation of [Currency Layer](https://currencylayer.com/documentation)

 */

struct CurrenciesDTO: Codable {
    
    enum CodingKeys: CodingKey {
        case currencies, success
    }

    var currencies: [Currency]
    var success: Bool
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        success = try container.decode(Bool.self, forKey: .success)
        let keyValDicts = try container.decode([String:String].self, forKey: .currencies)
        currencies = keyValDicts.map{ Currency(code: $0.key, name: $0.value) }
    }
}


/*
 Example response
 
 {
     "success": true,
     "terms": "https://currencylayer.com/terms",
     "privacy": "https://currencylayer.com/privacy",
     "currencies": {
         "AED": "United Arab Emirates Dirham",
         "AFN": "Afghan Afghani",
         "ALL": "Albanian Lek",
         "AMD": "Armenian Dram",
         "ANG": "Netherlands Antillean Guilder",
         [...]
     }
 }
 */


