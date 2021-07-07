//
//  Currency.swift
//  CurrencyConverter
//
//  Created by Tiago Chaves on 10/02/20.
//  Copyright © 2020 Tiago Chaves. All rights reserved.
//

import Foundation

struct Currency: Equatable, Comparable {
    let initials: String
    let name: String
    
    static func < (lhs: Currency, rhs: Currency) -> Bool {
        return lhs.name < rhs.name
    }
}
