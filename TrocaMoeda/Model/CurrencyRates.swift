//
//  CurrencyRates.swift
//  TrocaMoeda
//
//  Created by mac on 23/06/20.
//  Copyright © 2020 Saulo Freire. All rights reserved.
//

import Foundation

struct CurrencyRate: Codable {
    let success: Bool
    let terms: String
    let privacy: String
    let timestamp: Int
    let source: String
    let quotes: [String: Double]
}

struct CurrencyRateItem {
    var quote: Dictionary<String, Double>
}

extension CurrencyRateItem: Comparable, Equatable {
    static func < (left: CurrencyRateItem, right: CurrencyRateItem) -> Bool {
        if let leftKey = left.quote.first?.key, let rightKey = right.quote.first?.key {
            if (leftKey != rightKey){
                return leftKey < rightKey
            }
            return false
        }
        else {
            return false
        }
    }
    static func == (left: CurrencyRateItem, right: String) -> Bool {
        if let leftKey = left.quote.first?.key {
            let lowLeftKey = leftKey.lowercased()
            let lowRight = right.lowercased()
            if lowLeftKey.contains(lowRight) {
                return true
            }
            return false
        }
        return false
    }
}
