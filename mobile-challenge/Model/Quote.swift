//
//  Quote.swift
//  mobile-challenge
//
//  Created by Brunno Andrade on 05/10/20.
//

import Foundation

class Quote {
    var code: String
    var value: Float
    
    init(code: String, value: Float) {
        self.code = String(code.suffix(3))
        self.value = value
    }
}
