//
//  CurrencyAPIResponse.swift
//  CurrencyConverter
//
//  Created by Isnard Silva on 02/12/20.
//

import Foundation

protocol CurrencyAPIResponse: Codable {
    var success: Bool { get }
}

struct CurrencyNamesAPIResponse: CurrencyAPIResponse {
    let success: Bool
    let currencies: [String: String]
}

struct CurrencyValuesAPIResponse: CurrencyAPIResponse {
    let success: Bool
    let quotes: [String: Double]
}
