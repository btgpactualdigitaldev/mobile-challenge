//
//  CurrencyExchange.swift
//  ExampleProject
//
//  Created by Lucas Mathielo Gomes on 06/09/20.
//  Copyright © 2020 Lucas Mathielo Gomes. All rights reserved.
//

import Foundation

class CurrencyRatesList: ApiCall {
    var success: Bool
    var error: ApiError?
    var source: String?
    var rates: [CurrencyRate]?
    
    enum CodingKeys: String, CodingKey {
        case success
        case error
        case source
        case quotes
    }
    
    required init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        success = try container.decode(Bool.self, forKey: .success)
        error = try container.decodeIfPresent(ApiError.self, forKey: .error)
        source = try container.decodeIfPresent(String.self, forKey: .source)
        guard let currencies = try container.decodeIfPresent([String: Double].self, forKey: .quotes) else { return }
        
        var classBasedCurrencies = [CurrencyRate]()
        for currency in currencies {
            let classCurrency = CurrencyRate(initials: currency.key, rate: currency.value)
            classBasedCurrencies.append(classCurrency)
        }
        
        self.rates = classBasedCurrencies
    }
}

class CurrencyRate {
    let initials: String
    let rate: Double
    
    init(initials: String, rate: Double) {
        self.initials = initials
        self.rate = rate
    }
}
