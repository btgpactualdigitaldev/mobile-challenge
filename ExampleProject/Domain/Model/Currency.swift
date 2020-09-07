//
//  Currency.swift
//  ExampleProject
//
//  Created by Lucas Mathielo Gomes on 03/09/20.
//  Copyright © 2020 Lucas Mathielo Gomes. All rights reserved.
//

import Foundation

class CurrencyList: ApiCall {
    
    var success: Bool
    var error: ApiError?
    var currencies: [Currency]?
    
    enum CodingKeys: String, CodingKey {
        case success
        case currencies
        case error
    }
    
    required init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        success = try container.decode(Bool.self, forKey: .success)
        error = try container.decodeIfPresent(ApiError.self, forKey: .error)
        guard let currencies = try container.decodeIfPresent([String: String].self, forKey: .currencies) else { return }
        
        var classBasedCurrencies = [Currency]()
        for currency in currencies {
            let classCurrency = Currency(initials: currency.key, name: currency.value)
            classBasedCurrencies.append(classCurrency)
            CoreDataManager.shared.saveIfNew(initials: classCurrency.initials, name: classCurrency.name)
        }
        
        classBasedCurrencies.sort(by: { $0.initials < $1.initials })
        
        self.currencies = classBasedCurrencies
    }
}

class Currency {
    let initials: String
    let name: String
    
    init(initials: String, name: String) {
        self.initials = initials
        self.name = name
    }
    
    init?(from model: CurrencyModel) {
        guard let initials = model.initials, let name = model.name  else { return nil }
        
        self.initials = initials
        self.name = name
    }
}
