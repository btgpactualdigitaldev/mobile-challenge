//
//  QueryResponse.swift
//  BtgChallenge
//
//  Created by Felipe Alexander Silva Melo on 13/05/20.
//  Copyright © 2020 Felipe Alexander Silva Melo. All rights reserved.
//

import Foundation

struct QueryResponse: Codable {
    let fromCoin: String
    let toCoin: String
    let amount: Int
    
    enum CodingKeys: String, CodingKey {
        case fromCoin = "from"
        case toCoin = "to"
        case amount
    }
}
