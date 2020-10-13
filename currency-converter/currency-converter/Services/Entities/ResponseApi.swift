//
//  ResponseApi.swift
//  currency-converter
//
//  Created by Rodrigo Queiroz on 09/10/20.
//

import Foundation

struct ResponseCurrencyInfo: Codable {
    
    let success: Bool
    let currencies: [String: String]
    
}

struct ResponseCurrencyValues: Codable {
    
    let success: Bool
    let source: String
    let quotes: [String: Float]
    
}

