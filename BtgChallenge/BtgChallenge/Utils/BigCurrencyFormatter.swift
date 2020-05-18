//
//  BigCurrencyFormatter.swift
//  BtgChallenge
//
//  Created by Felipe Alexander Silva Melo on 18/05/20.
//  Copyright © 2020 Felipe Alexander Silva Melo. All rights reserved.
//

import Foundation

class BtgCurrencyFormatter {
    
    static var shared = BtgCurrencyFormatter()
    fileprivate var formatter = NumberFormatter()
    
    init() {
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
    }
    
    static func format(string: String) -> String {
        let decNumber = NSDecimalNumber(string: string).multiplying(by: 0.01)
        return shared.format(number: decNumber)
    }
    
    static func format(double: Double) -> String {
        return shared.format(number: NSNumber(value: double))
    }
    
    fileprivate func format(number: NSNumber) -> String {
        let newString = formatter.string(from: number)
        
        return newString ?? ""
    }
    
}
