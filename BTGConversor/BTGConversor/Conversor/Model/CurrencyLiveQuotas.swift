//
//  CurrencyLiveQuotas.swift
//  BTGConversor
//
//  Created by Franclin Cabral on 12/13/20.
//  Copyright © 2020 franclin. All rights reserved.
//

import Foundation

struct CurrencyLiveQuotas: Codable {
    let success: Bool
    let timestamp: Double
    let source: String
    let quotes: [String: Double]
}
