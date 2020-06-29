//
//  APIModels.swift
//  mobile-challenge-pedro-alvarez
//
//  Created by Pedro Alvarez on 27/06/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//


final class CurrencyConversionJSONModel: Decodable {
    
    var quotes: CurrencyValueRelation
    
    private enum CodingKeys: String, CodingKey {
        case quotes = "quotes"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        quotes = try container.decode(CurrencyValueRelation.self, forKey: .quotes)
    }
}

final class CurrencyListJSONModel: Decodable {
    
    var currencies: CurrencyNameRelation = CurrencyNameRelation()
    
    private enum CodingKeys: String, CodingKey {
        case currencies = "currencies"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        currencies = try container.decode(CurrencyNameRelation.self, forKey: .currencies)
    }
}
