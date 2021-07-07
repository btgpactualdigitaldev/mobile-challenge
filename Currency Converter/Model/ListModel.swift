//
//  ListModel.swift
//  Currency Converter
//
//  Created by Otávio Souza on 29/09/20.
//

import Foundation

struct ListModel: Codable {
    let success : Bool
    var currencies : Dictionary<String, String>
    
    init() {
        success = false
        currencies = Dictionary()
    }
    
    private enum CodingKeys: String, CodingKey {
        case success = "success"
        case currencies = "currencies"
    }
    
    func getCurrencyKeys() -> [String] {
        return Array(currencies.keys.sorted(by: { $0 < $1 }))
    }
    
    func getValue(forKey: String) -> String {
        return currencies[forKey] ?? ""
    }
}
