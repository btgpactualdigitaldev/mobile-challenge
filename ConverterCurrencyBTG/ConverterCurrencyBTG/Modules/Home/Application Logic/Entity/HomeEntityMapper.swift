//
//  HomeEntityMapper.swift
//  ConverterCurrencyBTG
//
//  Created by Thiago Vaz on 05/07/20.
//  Copyright © 2020 Thiago Santos. All rights reserved.
//

import Foundation

class CurrencyEntityMapper {
    
    static func mappingListCurrency(listCurrency: ListCurrenciesModel, listQuotes: ListQuotes) -> [CurrencyEntity] {
        var list = listCurrency.currencies.map({ (key, value) -> CurrencyEntity in
            return  CurrencyEntity(name: value, currency: key)
        })
        
        list = list.map({mappingListQuotes(homeEntites: $0, listQuotes: listQuotes)})
        
        return list.sorted{ $0.name < $1.name }
    }
    
    static func mappingListQuotes(homeEntites: CurrencyEntity, listQuotes: ListQuotes) -> CurrencyEntity {
        let quote = listQuotes.quotes.first(where: { $0.key == "USD\(homeEntites.currency)"})
        homeEntites.quotes = Decimal.fromDouble(quote?.value ?? .zero)
        return homeEntites
    }
}
