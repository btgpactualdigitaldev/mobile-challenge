//
//  CurrencyList.swift
//  Challenge
//
//  Created by Eduardo Raffi on 10/10/20.
//  Copyright © 2020 Eduardo Raffi. All rights reserved.
//

internal struct CurrencyList: Codable {
    
    enum CodingKeys: String, CodingKey {
        case success = "success"
        case terms = "terms"
        case privacy = "privacy"
        case currencies = "currencies"
    }

    let success: Bool
    let terms: String
    let privacy: String
    let currencies: [String : String]
}
