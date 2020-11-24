//
//  Coin.swift
//  btg-currency-converter
//
//  Created by Paulo Cremonine on 23/11/20.
//

import Foundation


struct CoinEntity: Codable {
    let success: Bool
    let terms: String
    let privacy: String
    let currencies: [String: String]?
}

