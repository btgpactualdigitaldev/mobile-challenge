//
//  CurrencyExchangeResponse.swift
//  mobile-challenge
//
//  Created by Murilo Teixeira on 26/09/20.
//

import Foundation

struct CurrencyExchangeResponse: Decodable {
    let success: Bool
    let error: ErrorResponse?
    let timestamp: Double
    let source: String?
    let quotes: [String:Double]?
}
