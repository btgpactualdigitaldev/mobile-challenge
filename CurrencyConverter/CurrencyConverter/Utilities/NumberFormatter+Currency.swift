//
//  NumberFormatter+Currency.swift
//  CurrencyConverter
//
//  Created by Tiago Chaves on 09/02/20.
//  Copyright © 2020 Tiago Chaves. All rights reserved.
//

import Foundation

extension NumberFormatter {
    
    func format(_ value: Double, toCurrency currencyInitials:String) -> String? {
        let formatter = getCurrencyFormatter(for: currencyInitials)
        return formatter.string(from: value as NSNumber)
    }
    
    private func getCurrencyFormatter(for currencyInitials: String) -> NumberFormatter {
        self.numberStyle = .currencyAccounting
        self.currencyCode = currencyInitials
        self.locale = Locale(identifier: "pt_BR")
        self.maximumFractionDigits = 2
        self.minimumFractionDigits = 2
        
        return self
    }
}
