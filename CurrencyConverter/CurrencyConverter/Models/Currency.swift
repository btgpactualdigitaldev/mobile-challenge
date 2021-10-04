//
//  Currency.swift
//  CurrencyConverter
//
//  Created by Eduardo Lopes on 29/09/21.
//

import Foundation

struct Currency: Codable {
    let success: Bool
    let currencies: [String: String]
}
