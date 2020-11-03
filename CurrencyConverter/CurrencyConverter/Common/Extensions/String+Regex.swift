//
//  String+Regex.swift
//  CurrencyConverter
//
//  Created by Breno Aquino on 31/10/20.
//

import Foundation

extension String {
    
    func filterNumbers() -> String {
        return formatWithRegex(pattern: "[0-9]", options: .caseInsensitive)
    }
    
    private func formatWithRegex(pattern: String, options: NSRegularExpression.Options) -> String {
        guard let regex = try? NSRegularExpression(pattern: pattern, options: options) else { return self }
        let string = self as NSString
        return regex
            .matches(in: self, options: [], range: NSRange(location: 0, length: count))
            .map {
                string.substring(with: $0.range)
            }.joined()
    }
}
