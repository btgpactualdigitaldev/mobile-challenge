//
//  CurrencyLive.swift
//  CurrencyExchange
//
//  Created by Carlos Fontes on 31/10/20.
//

import Foundation

struct CurrencyLive: Decodable {
    let success: Bool
    let quotes: [String:Double]?
}
