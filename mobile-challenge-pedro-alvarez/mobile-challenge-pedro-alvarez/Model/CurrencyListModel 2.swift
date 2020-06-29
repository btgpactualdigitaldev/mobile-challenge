//
//  CurrencyListModel.swift
//  mobile-challenge-pedro-alvarez
//
//  Created by Pedro Alvarez on 25/06/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

struct CurrencyListModel {
    let id: String
    let fullName: String
    
    static func getCurrencyList(fromJson json: CurrencyNameRelation) -> [CurrencyListModel] {
        var list: [CurrencyListModel] = []
        for (key, value) in json {
            let currency = CurrencyListModel(id: key, fullName: value)
            list.append(currency)
        }
        return list
    }
}
