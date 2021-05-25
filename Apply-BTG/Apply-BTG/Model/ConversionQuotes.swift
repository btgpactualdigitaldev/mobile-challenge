//
//  CurrencyConversionList.swift
//  Apply-BTG
//
//  Created by Adriano Rodrigues Vieira on 22/05/21.
//

import Foundation

struct ConversionQuotes: Codable {
    let source: String
    let all: [String: Double]
    
    enum CodingKeys: String, CodingKey {
        case source
        case all = "quotes"
    }
}
