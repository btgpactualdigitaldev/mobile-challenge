//
//  ListCurrencies.swift
//  CoinConversion
//
//  Created by Ronilson Batista on 18/07/20.
//  Copyright © 2020 Ronilson Batista. All rights reserved.
//

import Foundation

struct ListCurrencies: Codable {
    
    let success: Bool
    let terms: String
    let privacy: String
    let currencies: [String: String]
    
    enum CodingKeys: String, CodingKey {
        case success
        case terms
        case privacy
        case currencies
    }
}
