//
//  Double+Extensions.swift
//  mobile-challenge
//
//  Created by Matheus Brasilio on 25/10/20.
//  Copyright © 2020 Matheus Brasilio. All rights reserved.
//

import Foundation

extension Double {
    func formatCurrency(currencySymbol: String) -> String {
        let nf = NumberFormatter()
        nf.groupingSeparator = "."
        nf.decimalSeparator = ","
        nf.minimumFractionDigits = 2
        nf.maximumFractionDigits = 4
        nf.usesGroupingSeparator = true
        nf.numberStyle = .decimal
        return "\(currencySymbol) \(nf.string(from: NSNumber(floatLiteral: self)) ?? "\(currencySymbol) \(self)")"
    }
}
