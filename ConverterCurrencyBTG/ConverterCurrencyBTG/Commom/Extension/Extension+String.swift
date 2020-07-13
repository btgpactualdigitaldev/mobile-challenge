//
//  Extension+String.swift
//  ConverterCurrencyBTG
//
//  Created by Thiago Vaz on 05/07/20.
//  Copyright © 2020 Thiago Santos. All rights reserved.
//

import Foundation

extension String {
    
    public func toCurrency() -> String? {
        let allowedCharset = "0123456789"
        let stripedText = String(self.filter(allowedCharset.contains))
        guard !stripedText.isEmpty else { return "" }

        let formatter = NumberFormatter()
        formatter.locale = Locale(identifier: "pt_BR")  // could be current locale here, but this is for a Brazilian app
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 2
        formatter.minimumFractionDigits = 2

        let double = (stripedText as NSString).doubleValue
        let number = NSNumber(value: (double / 100))

        guard number != 0 as NSNumber else {
            return ""
        }

        return formatter.string(from: number)
    }

}
