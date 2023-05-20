//
//  String.swift
//  Coin Converter
//
//  Created by Andre Casarini on 18/08/20.
//  Copyright © 2020 Andre Casarini. All rights reserved.
//

import Foundation

extension String {
    
    
    // MARK: - Public Properties
    
    
    var digits: String {
        return components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
    }
    
    
    // MARK: - Public Methods
    
    
    func toCurrency() -> String {
        
        let formatter: NumberFormatter = NumberFormatter()
        formatter.numberStyle = .currencyAccounting
        formatter.currencySymbol = ""
        formatter.maximumFractionDigits = 2
        formatter.minimumFractionDigits = 2
        
        let amountWithPrefix: String = self.digits
        let double: Double? = Double(amountWithPrefix)
        let number: NSNumber = NSNumber(value: (double!/100))
        
        guard number != 0 as NSNumber else {
            return ""
        }
        
        return formatter.string(from: number)!
    }
    
}
