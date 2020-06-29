//
//  CurrencyModel.swift
//  mobile-challenge-pedro-alvarez
//
//  Created by Pedro Alvarez on 25/06/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

struct CurrencyConvertionModel {
    let id: String
    let dolarValue: Double
    
    static func getCurrencyConvertions(_ json: CurrencyValueRelation) -> [CurrencyConvertionModel] {
        var list: [CurrencyConvertionModel] = []
        for (key, value) in json {
            let currencyRelation = CurrencyConvertionModel(id: key, dolarValue: value)
            list.append(currencyRelation)
        }
        return list
    }

    static func convert(value: Double, first currency1: CurrencyConvertionModel, second currency2: CurrencyConvertionModel) -> Double {
        let fromDolarCurrency = currency1.dolarValue
        let toDolarCurrency = currency2.dolarValue
        
        return value * toDolarCurrency / fromDolarCurrency
    }
}
