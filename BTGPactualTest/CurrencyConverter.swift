//
//  Converter.swift
//  BTGPactualTest
//
//  Created by Vinicius Custodio on 17/06/20.
//  Copyright © 2020 Vinicius Custodio. All rights reserved.
//

import Foundation

class CurrencyConverter {
    static let manager = CurrencyConverter()
    
    private var service = APILayerService()
    var currencies: [Currency]?
    var quotes: [String: Quote]?
    
    private init(){}
    
    func getCurrencies() -> [Currency] {
        return currencies ?? []
    }
    
    func loadCurrencies(completion: @escaping (() -> Void),
                        failure: @escaping (String) -> Void) {
        service.getList { response in
            switch response {
                
            case .success(let currencies):
                self.currencies = currencies.sorted(by: {$0.code < $1.code})
                completion()
                
            case .failure(let error):
                failure(error.localizedDescription)
            }
        }
    }
    
    func loadQuotes(completion: @escaping (() -> Void),
                    failure: @escaping (String) -> Void ) {
        service.getQuotes(completionHandler: { response in
            switch response {
            case .failure(let error):
                failure(error.localizedDescription)
                
            case .success(let quotes):
                self.quotes = quotes
                completion()
                
            }
        })
    }
    
    func convert(value: Float,
                 from originCurrency: Currency,
                 to destinyCurrency: Currency) -> Float? {
        
        if let originQuote = self.quotes![originCurrency.quoteKey],
            let destinyQuote = self.quotes![destinyCurrency.quoteKey] {
            
            let usdValue = value / originQuote.value
            let destinyValue = usdValue * destinyQuote.value
            
            return destinyValue
        }
        
        return nil
    }
}
