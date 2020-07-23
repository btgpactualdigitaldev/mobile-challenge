//
//  CurrenciesConversion.swift
//  CoinConversion
//
//  Created by Ronilson Batista on 18/07/20.
//  Copyright © 2020 Ronilson Batista. All rights reserved.
//

import Foundation

struct CurrenciesConversion: Codable {
    
    let success: Bool
    let terms: String
    let privacy: String
    let timestamp: Double
    let source: String
    let quotes: [String: Double]
    
    enum CodingKeys: String, CodingKey {
        case success
        case terms
        case privacy
        case timestamp
        case source
        case quotes
    }
}
