//
//  Double+Extension.swift
//  DesafioBTG
//
//  Created by Bittencourt Mantavani, Rômulo on 03/09/20.
//  Copyright © 2020 Bittencourt Mantovani, Rômulo. All rights reserved.
//

import Foundation

extension Double {
    func formatCurrencyFrom(currencyCode code: String) -> String? {
        let formatter = NumberFormatter()
        formatter.locale = Locale(currencyCode: code)
        formatter.numberStyle = .decimal
        formatter.usesGroupingSeparator = true
        formatter.maximumFractionDigits = 2
        formatter.minimumFractionDigits = 2
        formatter.minimumIntegerDigits = 1
        
        return formatter.currencySymbol + " " + (formatter.string(from: NSNumber(value: self / 100)) ?? "0,00")
    }
}
