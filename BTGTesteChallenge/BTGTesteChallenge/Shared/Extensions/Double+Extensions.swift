//
//  Double+Extensions.swift
//  BTGTesteChallenge
//
//  Created by Rafael  Hieda on 2/6/20.
//  Copyright © 2020 Rafael_Hieda. All rights reserved.
//

import Foundation

extension Double {
    ///Method to help rounding to a speciifc number of digits inspired by https://stackoverflow.com/questions/27338573/rounding-a-double-value-to-x-number-of-decimal-places-in-swift
    mutating func roundWith(precision digits: Int) -> Self {
        let divisor = pow(10.0, Double(digits))
        return (self * divisor).rounded() / divisor
    }
}
