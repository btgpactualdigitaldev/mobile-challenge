//
//  String+ContainsDecimalSeparator.swift
//  mobile-challenge-UIKit
//
//  Created by Lucas Fernandez Nicolau on 19/12/20.
//

import Foundation

extension String {
    
    static var decimalSeparator: String {
        return Locale.current.decimalSeparator ?? "."
    }

    /// Returns if this string contains some decimal separator
    /// - Returns: true or false
    func containsDecimalSeparator() -> Bool {
        return self.contains(".")
            || self.contains(",")
            || self.contains(String.decimalSeparator)
    }

    /// Returns if this string is some decimal separator
    /// - Returns: true or false
    func isDecimalSeparator() -> Bool {
        return self == "."
            || self == ","
            || self == String.decimalSeparator
    }

    /// Returns the number of decimal separators are in the String
    /// - Returns: number of decimal separators
    func numberOfDecimalSeparators() -> Int {
        return self.filter { String($0) == String.decimalSeparator }.count
    }
}
