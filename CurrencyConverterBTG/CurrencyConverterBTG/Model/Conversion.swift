//
//  Conversion.swift
//  CurrencyConverterBTG
//
//  Created by Alex Nascimento on 23/03/21.
//

import Foundation

struct Conversion: Codable {
    
    var code: String
    var value: Double
    
    static func convert(from c1: Currency, to c2: Currency, conversions list: [Conversion], amount: Double) -> Double? {
        guard let oneDolarInOriginCurrency = list.filter({ conversion in
            conversion.code == "USD" + c1.code
        }).first?.value else {
            Debugger.warning("No conversion found")
            return nil
        }
        
        guard let oneDolarInDestinyCurrency = list.filter({ conversion in
            conversion.code == "USD" + c2.code
        }).first?.value else {
            Debugger.warning("No conversion found")
            return nil
        }
        
        let result = (oneDolarInDestinyCurrency / oneDolarInOriginCurrency) * amount
        return result
    }
}
