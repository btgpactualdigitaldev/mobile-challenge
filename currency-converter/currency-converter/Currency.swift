//
//  Currency.swift
//  currency-converter
//
//  Created by Admin Colaborador on 09/10/20.
//

import Foundation

struct CurrencyInfo: Codable {
    
    let success: Bool
    let currencies: [String: String]
    
}

struct CurrencyValues: Codable {
    
    let success: Bool
    let source: String
    let quotes: [String: Float]
    
}
