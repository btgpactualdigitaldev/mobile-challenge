//
//  Decimal+Currency.swift
//  BTG-Currency
//
//  Created by Ramon Almeida on 28/10/21.
//

import Foundation

extension Decimal {
    public func toCurrency(withCode code: String) -> String {
        guard let locale = Locale.getLocale(byCurrencyCode: code) else {
            return "$" + String(format: "%.2f", self as CVarArg)
        }
        
        let formatter = NumberFormatter()
        formatter.locale = locale
        formatter.numberStyle = .currency
        formatter.groupingSize = 3
        formatter.decimalSeparator = locale.decimalSeparator
        formatter.groupingSeparator = locale.groupingSeparator
        
        if let string = formatter.string(from: NSDecimalNumber(decimal: self)) {
            return string
        } else {
            return "$" + String(format: "%.2f", self as CVarArg)
        }
    }
}
