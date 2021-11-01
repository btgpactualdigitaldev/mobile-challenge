//
//  String+Currency.swift
//  BTG-Currency
//
//  Created by Ramon Almeida on 28/10/21.
//

import Foundation

extension String {
    private var regex: NSRegularExpression {
        try! NSRegularExpression(pattern: "[^0-9]", options: .caseInsensitive)
    }
    
    public func toCurrency(withCode code: String) -> String {
        let locale = Locale.getLocale(byCurrencyCode: code)
        
        var number: NSNumber!
        let formatter = NumberFormatter()
        formatter.locale = locale
        formatter.numberStyle = .currencyAccounting
        formatter.currencySymbol = locale?.currencySymbol
        formatter.maximumFractionDigits = 2
        formatter.minimumFractionDigits = 2
        var amountWithPrefix = self
        
        amountWithPrefix = regex.stringByReplacingMatches(in: amountWithPrefix, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSRange(0..<self.count), withTemplate: "")
        
        let double = (amountWithPrefix as NSString).doubleValue
        number = NSNumber(value: double / 100)
        
        return formatter.string(from: number)!
    }
    
    public func toDecimal() -> Decimal {
        var number: NSNumber!
        var amountWithPrefix = self
        
        amountWithPrefix = regex.stringByReplacingMatches(in: amountWithPrefix, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSRange(0..<self.count), withTemplate: "")
        
        let double = (amountWithPrefix as NSString).doubleValue
        number = NSNumber(value: double / 100)
        
        return number.decimalValue
    }
}
