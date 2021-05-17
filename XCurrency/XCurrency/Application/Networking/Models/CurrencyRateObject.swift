//
//  CurrencyRateObject.swift
//  XCurrency
//
//  Created by Vinicius Nadin on 29/03/21.
//

struct CurrencyRateObject: Codable {

    // MARK: - Attributes
    let currenciesRate: [CurrencyRate]

    // MARK: - Keys Enum
    enum Keys: String, CodingKey {
        case quotes
    }

    // MARK: - Initializer
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Keys.self)
        let currenciesDictionary: [String: Double] = try container.decode([String: Double].self, forKey: .quotes)
        self.currenciesRate = currenciesDictionary.map { currencieRate in
            CurrencyRate(source: currencieRate.key, value: currencieRate.value)
        }
    }
}
