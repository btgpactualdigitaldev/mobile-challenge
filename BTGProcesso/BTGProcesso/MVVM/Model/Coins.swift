//
//  Coins.swift
//  BTGProcesso
//
//  Created by Lelio Jorge Junior on 08/12/20.
//

import Foundation


struct Coins {
    var success: Bool
    var coins: [String: String]
    
}

extension Coins: Decodable {
    enum CodingKeys: String, CodingKey {
        case success
        case coins = "currencies"
    }
}
