//
//  CurrencyList.swift
//  TrocaMoeda
//
//  Created by mac on 23/06/20.
//  Copyright © 2020 Saulo Freire. All rights reserved.
//

import Foundation

struct CurrencyList: Codable {
    let terms: String
    let privacy: String
    let currencies: [String:String]
}

struct CurrencyTableItem {
    
    var currency: Dictionary<String, String>
    
    mutating func translateCurrency() -> Dictionary<String, String>? {
        if let selectedCurrency = currency.first?.key, let translation = TranslatedCurrencies.shared.currencies[selectedCurrency] {
            return [selectedCurrency: translation]
        } else {
            return self.currency
        }
    }
    
    init(currency: Dictionary<String, String>) {
        self.currency = currency
        if let currencyTranslation = self.translateCurrency() {
            self.currency = currencyTranslation
        }
    }
    
}

extension CurrencyTableItem: Comparable, Equatable {
    static func < (left: CurrencyTableItem, right: CurrencyTableItem) -> Bool {
        if let leftKey = left.currency.first?.key, let rightKey = right.currency.first?.key {
            if (leftKey != rightKey){
                return leftKey < rightKey
            }
            return false
        }
        else {
            return false
        }
    }
    static func == (left: CurrencyTableItem, right: String) -> Bool {
        if let leftKey = left.currency.first?.key, let leftValue = left.currency.first?.value {
            let lowLeftKey = leftKey.lowercased()
            let lowLeftValue = leftValue.lowercased()
            let lowRight = right.lowercased()
            if lowLeftKey.contains(lowRight) {
                return true
            }
            else if lowLeftValue.contains(lowRight) {
                return true
            }
            return false
        }
        return false
    }
}
