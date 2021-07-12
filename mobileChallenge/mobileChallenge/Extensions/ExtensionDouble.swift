//
//  ExtensionDouble.swift
//  mobileChallenge
//
//  Created by Mateus Augusto M Ferreira on 27/11/20.
//

import Foundation


extension Double {
    func roundToDecimal(_ fractionDigits: Int) -> Double {
        let multiplier = pow(10, Double(fractionDigits))
        return Darwin.round(self * multiplier) / multiplier
    }
}
