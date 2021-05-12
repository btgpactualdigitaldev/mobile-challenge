//
//  MathUtils.swift
//  CurrencyConverterBTG
//
//  Created by Alex Nascimento on 25/03/21.
//

import Foundation

extension Int {
    
    func isBetween(v1: Int, v2: Int) -> Bool {
        let (bigger, smaller) = v1 > v2 ? (v1, v2) : (v2, v1)
        return self <= bigger && self >= smaller
    }
}
