//
//  Currency.swift
//  BTG-Currency
//
//  Created by Ramon Almeida on 27/10/21.
//

import Foundation

public struct Currency {
    public var value: Decimal
    public var code: String
    
    public init(value: Decimal = 0.0, code: String) {
        self.value = value
        self.code = code
    }
}
