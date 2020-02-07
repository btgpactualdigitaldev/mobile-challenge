//
//  ConvertCurrencyModel.swift
//  BTGTesteChallenge
//
//  Created by Rafael  Hieda on 2/4/20.
//  Copyright © 2020 Rafael_Hieda. All rights reserved.
//

import Foundation

struct CurrencyRate : Decodable {
    var success: Bool?
    var terms: String?
    var privacy: String?
    var timestamp: Double?
    var source: String?
    var quotes: [String:Double]?
    
    enum CodingKeys: CodingKey {
        case success
        case terms
        case privacy
        case timestamp
        case source
        case quotes
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        success = try container.decode(Bool.self, forKey: .success)
        terms = try container.decode(String.self, forKey: .terms)
        privacy = try container.decode(String.self, forKey: .privacy)
        source = try container.decode(String.self, forKey: .source)
        timestamp = try container.decode(TimeInterval.self, forKey: .timestamp)
        quotes = try container.decode([String:Double].self, forKey: .quotes)
    }
}
