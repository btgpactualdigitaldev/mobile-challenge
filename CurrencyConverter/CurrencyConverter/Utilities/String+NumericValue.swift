//
//  String+NumericValue.swift
//  CurrencyConverter
//
//  Created by Tiago Chaves on 14/02/20.
//  Copyright © 2020 Tiago Chaves. All rights reserved.
//

import Foundation

extension String {
    
    func getCurrencyNumericValue() -> Double {
        var textValue = self
        
        let regex = try! NSRegularExpression(pattern: "[^0-9]", options: .caseInsensitive)
        textValue = regex.stringByReplacingMatches(in: textValue,
                                                   options: NSRegularExpression.MatchingOptions(rawValue: 0),
                                                   range: NSMakeRange(0, self.count),
                                                   withTemplate: "")
        
        guard let numericValue = Double(textValue) else {
            return 0.0
        }
        
        return numericValue / 100
    }
}
