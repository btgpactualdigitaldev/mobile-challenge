//
//  CurrencyConverterViewModel.swift
//  mobile-challenge
//
//  Created by Brunno Andrade on 03/10/20.
//

import Foundation

class CurrencyConverterViewModel {
    
    let title: String = "Conversor de Moeda"
    private(set) var quotes: [Quote] = []
    
    private(set) var selectedOrigin: Quote?
    private(set) var selectedDestiny: Quote?
    
    func quoteSelect(type: TypeConverter, code: String) {
        
        if let quote = self.searchQuote(with: code) {
            switch type {
            case .origin:
                self.selectedOrigin = quote
            case .destiny:
                self.selectedDestiny = quote
            }
        }
    }
    
    func searchQuote(with code: String) -> Quote? {
        return self.quotes.first(where: { $0.code == code })
    }
    
    func converterCurrency(_ value: Float) -> String {
        if let origin = selectedOrigin, let destiny = selectedDestiny {
            if origin.code == "USD" {
                return (destiny.value * value).formatCurrency()
            } else {
                return ((value / origin.value) * destiny.value).formatCurrency()
            }
        }
        return ErrorHandler.converterError.rawValue
    }
    
    func setQuotesArray(quoteList: QuoteList) {
        if let quotes = quoteList.quotes {
            
            self.quotes = quotes.map {
                return Quote(code: $0.key, value: $0.value )
            }
        }
    }
}
