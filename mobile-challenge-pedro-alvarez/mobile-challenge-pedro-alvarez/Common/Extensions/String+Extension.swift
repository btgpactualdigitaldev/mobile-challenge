//
//  String+Extension.swift
//  mobile-challenge-pedro-alvarez
//
//  Created by Pedro Alvarez on 24/06/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//
import Foundation

extension String {
    
    static var empty: String {
        return ""
    }
    
    static var dot: String {
        return "."
    }
    
    static var interrogation: String {
        return "?"
    }
    
    static var space: String {
        return " "
    }
    
    static var usd: String {
        return "USD"
    }
    
    func toDouble() -> Double? {
        return NumberFormatter().number(from: self)?.doubleValue
    }
}
