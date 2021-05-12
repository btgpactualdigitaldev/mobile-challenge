//
//  ConversionsDTO.swift
//  CurrencyConverterBTG
//
//  Created by Alex Nascimento on 23/03/21.
//

import Foundation

/**
  For API Documentation of [Currency Layer](https://currencylayer.com/documentation)

 */

struct ConversionsDTO: Codable {
    
    enum CodingKeys: String, CodingKey {
        case conversions = "quotes"
    }
    
    let conversions: [Conversion]
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let keyValueDict = try container.decode([String:Double].self, forKey: .conversions)
        conversions = keyValueDict.map { Conversion(code: $0.key, value: $0.value) }
    }
}


/*
 Example response
 
 {
     "success": true,
     "terms": "https://currencylayer.com/terms",
     "privacy": "https://currencylayer.com/privacy",
     "timestamp": 1616379186,
     "source": "USD",
     "quotes": {
         "USDAED": 3.6732,
         "USDAFN": 77.748564,
         "USDALL": 103.755685,
         "USDAMD": 527.870354,
         "USDANG": 1.797192,
         [...]
 */
