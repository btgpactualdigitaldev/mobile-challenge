//
//  BTGCurrencyDescriptionModel.swift
//  BTGConverterAPP
//
//  Created by Leonardo Maia Pugliese on 16/05/20.
//  Copyright © 2020 Leonardo Maia Pugliese. All rights reserved.
//

import Foundation

struct CurrencyDescription: Hashable, Codable {
    let identifier: UUID = UUID()
    let abbreviation : String
    let fullDescription: String
    
    static func ==(lhs: CurrencyDescription, rhs: CurrencyDescription) -> Bool {
        return lhs.abbreviation == rhs.abbreviation &&
            lhs.fullDescription == rhs.fullDescription &&
            lhs.hashValue == rhs.hashValue
    }
    
    static func !=(lhs: CurrencyDescription, rhs: CurrencyDescription) -> Bool {
        return lhs.hashValue != rhs.hashValue
    }
}
