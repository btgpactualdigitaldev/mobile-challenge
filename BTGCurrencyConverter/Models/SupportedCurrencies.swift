//
//  SupportedCurrencies.swift
//  BTGCurrencyConverter
//
//  Created by Ian McDonald on 22/07/20.
//  Copyright © 2020 Ian McDonald. All rights reserved.
//

import Foundation

struct SupportedCurrencies: Codable, Hashable {
    let currencies: [String: String]
}
