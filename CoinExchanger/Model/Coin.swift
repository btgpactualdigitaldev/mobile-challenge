//
//  Coin.swift
//  CoinExchanger
//
//  Created by Edson Rottava on 03/09/21.
//

import Foundation

class Coin: Codable {
    var code: String?
    var name: String?
    var quote: Double?
    
    init(_ code: String? = nil,
         _ name: String? = nil,
         _ quote: Double? = nil) {
        self.code = code
        self.name = name
        self.quote = quote
    }
    
    init(_ item: Dictionary<String, String>.Element?) {
        self.code = item?.key
        self.name = item?.value
        self.quote = 1
    }
    
    enum CodingKeys: String, CodingKey {
        case code = "code"
        case name = "name"
        case quote = "quote"
    }
}
