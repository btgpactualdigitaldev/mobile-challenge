//
//  CurrencyQuotes.swift
//  mobile-challenge
//
//  Created by gabriel on 29/11/20.
//

import Foundation

/**
 Model of the currency quotes designed from the API needed attributes.
 */
struct CurrencyQuotes: Codable {
    let lastUpdate: Date
    let source: String
    let quotes: [String: Double]
    
    enum CodingKeys: String, CodingKey {
        case quotes, source, lastUpdate = "timestamp"
    }
    
    init(from decoder: Decoder) throws {
        // Decoding manually is necessary due to Date deserialization
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        let timestamp = try container.decode(TimeInterval.self, forKey: .lastUpdate)
        lastUpdate = Date(timeIntervalSince1970: timestamp)
                
        source = try container.decode(String.self, forKey: .source)
        quotes = try container.decode([String: Double].self, forKey: .quotes)
    }
}
