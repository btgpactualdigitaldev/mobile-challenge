//
//  CurrenciesContainerModel.swift
//  Coin Converter
//
//  Created by Jeferson Hideaki Takumi on 27/06/20.
//  Copyright © 2020 Takumi. All rights reserved.
//

struct CurrenciesContainerModel: Decodable {
    let success: Bool
    let terms: String?
    let privacy: String?
    let currencies: [CurrencyModel]?
    let error: ErrorModel?
    
    private enum QuotesModelKey: String, CodingKey {
        case success
        case terms
        case privacy
        case currencies
        case error
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: QuotesModelKey.self)
        success = try container.decode(Bool.self, forKey: .success)
        terms = try container.decodeIfPresent(String.self, forKey: .terms)
        privacy = try container.decodeIfPresent(String.self, forKey: .privacy)
        
        if let currenciesObject: [String: String] = try container.decodeIfPresent([String: String].self, forKey: .currencies) {
            var currencies: [CurrencyModel] = []
            for (key,value) in currenciesObject {
                currencies.append(CurrencyModel(symbol: key, descriptionCurrency: value))
            }
            
            self.currencies = currencies
        } else {
            currencies = nil
        }
        
        error = try container.decodeIfPresent(ErrorModel.self, forKey: .error)
    }
}
