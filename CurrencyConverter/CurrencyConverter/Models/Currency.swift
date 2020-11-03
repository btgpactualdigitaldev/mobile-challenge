//
//  Currency.swift
//  CurrencyConverter
//
//  Created by Breno Aquino on 30/10/20.
//

import Foundation
import CurrencyServices

class Currecy {
    let code: String
    let name: String
    var inDolarValue: Double?
    
    var fullDescription: String { "\(code) (\(name))" }
    
    init(code: String, name: String) throws {
        self.code = code
        self.name = name
        inDolarValue = nil
    }
}
