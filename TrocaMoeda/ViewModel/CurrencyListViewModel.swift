//
//  CurrencyListViewModel.swift
//  TrocaMoeda
//
//  Created by mac on 23/06/20.
//  Copyright © 2020 Saulo Freire. All rights reserved.
//

import Foundation

enum CurrencyAPIData: Equatable {
    case CurrencyList
    case CurrencyRate
    
}
func ==(left: String, right: CurrencyAPIData) -> Bool {
    if left == right {
        return true
    } else {
        return false
    }
}

extension Array where Element: Equatable {
    func all(where predicate: (Element) -> Bool) -> [Element] {
        return self.compactMap { predicate($0) ? $0 : nil }
    }
}

class CurrencyListViewModel {
    
    var CTIArray: [CurrencyTableItem] = []
    var rates: [CurrencyRateItem] = []
    var searchArray: [CurrencyTableItem] = []
    var rateSearch: [CurrencyRateItem] = []
    
    func fetchCurrencies(from endpoint: String, type: CurrencyAPIData, completion: (() -> Void)? = nil, errorHandler: (() -> Void)? = nil ){
        let URLString = endpoint
        let apiUtils = APIUtils()
        if let url = URL(string: URLString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    if let errorAction = errorHandler {
                        errorAction()
                    }
                }
                if let receivedData = data {
                    let parsedJSON = apiUtils.parseResponse(receivedData, type: type)
                    if let list = parsedJSON.0 {
                        self.CTIArray = apiUtils.CTIArrayBuilder(from: list)
                        if let callback = completion {
                            callback()
                        }
                    } else if let rates = parsedJSON.1 {
                        self.rates = apiUtils.CRArrayBuilder(from: rates)
                        if let callback = completion {
                            callback()
                        }
                    }
                    
                    else {
                        if let errorAction = errorHandler {
                            errorAction()
                        }
                    }
                }
            }
            task.resume()
        }
        
    }
    
    func searchCurrency(with term: String) {
        if CTIArray.count > 0 {
            searchArray = CTIArray.all(where: {$0 == term})
        }
    }
    
    func searchRate(with term: String) -> CurrencyRateItem? {
            var searchTerm = term
            if term == "USD" {
                searchTerm = "USDUSD"
            }
           if rates.count > 0 {
               rateSearch = rates.all(where: {$0 == searchTerm})
                return rateSearch.first
           } else {
                return nil
            }
       }
    
    func calc(from: String, to: String, amount: String) -> String? {

        let originCurrency = searchRate(with: from)
        let destinationCurrency = searchRate(with: to)
        
        var quantity = amount
        if quantity.contains(".") {
            quantity = String(quantity.split(separator: ".").joined())
        }
        
        if let first = originCurrency?.quote.first?.value, let sec = destinationCurrency?.quote.first?.value {
            let formatter = NumberFormatter()
            if let number = formatter.number(from: quantity) {
                let convertedDouble = number.doubleValue
                let firstToUSD = (1 / first) * convertedDouble
                let secondToUSD = sec * firstToUSD
                return Formatter.currency.string(from: NSNumber(value: secondToUSD))
            }
        }
        return nil
    }
    
    func destroySearch() {
        if searchArray.count > 0 {
            searchArray.removeAll()
        }
    }
    
    
    
}
