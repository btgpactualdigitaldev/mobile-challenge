//
//  DoubleExtension.swift
//  ChallengerConverter
//
//  Created by ADRIANO.MAZUCATO on 25/10/21.
//

import Foundation


extension Double {
    
    func toCyrrency(currencyCode: String)-> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencyCode = currencyCode
        formatter.maximumFractionDigits = 2
        return formatter.string(from: NSNumber(value: self))!
    }
    
}
