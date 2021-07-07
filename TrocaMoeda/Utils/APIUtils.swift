//
//  APIUtils.swift
//  TrocaMoeda
//
//  Created by mac on 23/06/20.
//  Copyright © 2020 Saulo Freire. All rights reserved.
//

import Foundation

struct APIUtils {
    func parseResponse(_ responseData: Data, type: CurrencyAPIData) -> (CurrencyList?, CurrencyRate?){
        let decoder = JSONDecoder()
        do {
            switch type {
            case .CurrencyList:
                let decoded = try decoder.decode(CurrencyList.self, from: responseData)
                return (decoded, nil)
            case .CurrencyRate:
                let decoded = try decoder.decode(CurrencyRate.self, from: responseData)
                return (nil, decoded)
            }

        } catch {
            print(error)
            return (nil, nil)
        }
    }
    
    //MARK: - Currency Table Item Array Builder

    func CTIArrayBuilder(from data: CurrencyList) -> [CurrencyTableItem] {
        var currencyArray: [CurrencyTableItem] = []
        for (key,currency) in data.currencies {
            let currencyTableItem = CurrencyTableItem(currency: [key: currency])
            currencyArray.append(currencyTableItem)
        }
        currencyArray.sort(by: <)
        return currencyArray
    }

    //MARK: - Currency Rate Item Array Builder

    func CRArrayBuilder(from data: CurrencyRate) -> [CurrencyRateItem] {
        var rates: [CurrencyRateItem] = []
        for (key,quote) in data.quotes {
            let currencyTableItem = CurrencyRateItem(quote: [key: quote])
            rates.append(currencyTableItem)
        }
        rates.sort(by: <)
        return rates
    }
}
