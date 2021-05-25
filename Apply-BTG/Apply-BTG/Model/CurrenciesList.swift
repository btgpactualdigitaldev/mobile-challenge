//
//  CurrenciesList.swift
//  Apply-BTG
//
//  Created by Adriano Rodrigues Vieira on 21/05/21.
//

import Foundation

struct CurrenciesList: Codable {
    let success: Bool
    let all: [String: String]
    
    enum CodingKeys: String, CodingKey {
        case success
        case all = "currencies"
    }
}


