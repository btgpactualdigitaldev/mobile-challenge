//
//  CurrencyLiveResult.swift
//  Conversor de moedas
//
//  Created by Matheus Duraes on 23/12/20.
//

import Foundation

struct CurrencyLiveResult: Codable {
    let success: Bool
    let terms, privacy: String
    let timestamp: Int
    let source: String
    let quotes: [String: Double]
}
