//
//  CurrencyList.swift
//  mobile-challenge-UIKit
//
//  Created by Lucas Fernandez Nicolau on 16/12/20.
//

import Foundation

struct CurrencyList: Codable {
    enum Keys: CodingKey {
        case currencies
    }

    var currencies: [Currency]

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Keys.self)
        let currenciesDict = try container.decode([String: String].self, forKey: .currencies)

        currencies = currenciesDict.map {
            Currency(code: $0.key, name: $0.value)
        }
    }
}
