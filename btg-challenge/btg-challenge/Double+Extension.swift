//
//  Double+Extension.swift
//  btg-challenge
//
//  Created by Wesley Araujo on 14/09/20.
//  Copyright © 2020 Wesley Araujo. All rights reserved.
//

import Foundation

extension Double {
    public func convertToDollar(by quote: Double) -> Double {
        if quote <= 1.0 {
            return self * quote
        }
        return self / quote
    }
    
    public func convertDollarToCurrency(by quote: Double) -> Double {
        return self * quote
    }
    
    public func convertToCurrency(quoteSource: Double, quoteDestiny: Double) -> Double {
        let dollarValue = self.convertToDollar(by: quoteSource)
        let value = dollarValue.convertDollarToCurrency(by: quoteDestiny)
        return value
    }
    
    func rounded(toPlaces places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}
