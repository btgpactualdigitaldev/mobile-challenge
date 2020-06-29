//
//  CurrencyModel.swift
//  mobile-challenge-pedro-alvarez
//
//  Created by Pedro Alvarez on 25/06/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

struct CurrencyConversionModel: Equatable {
    let id: String
    let dolarValue: Double
    
    static func getCurrencyConversions(_ json: CurrencyValueRelation) -> [CurrencyConversionModel] {
        var list: [CurrencyConversionModel] = []
        for (key, value) in json {
            let currencyRelation = CurrencyConversionModel(id: key, dolarValue: value)
            list.append(currencyRelation)
        }
        return list
    }

    static func convert(value: Double, first currency1: CurrencyConversionModel, second currency2: CurrencyConversionModel) -> Double {
        let fromDolarCurrency = currency1.dolarValue
        let toDolarCurrency = currency2.dolarValue
        
        return value * toDolarCurrency / fromDolarCurrency
    }
}
