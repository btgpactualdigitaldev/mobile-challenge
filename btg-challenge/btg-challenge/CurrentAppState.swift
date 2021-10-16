//
//  CurrentState.swift
//  btg-challenge
//
//  Created by Wesley Araujo on 14/09/20.
//  Copyright © 2020 Wesley Araujo. All rights reserved.
//

import Foundation

class CurrentAppState {
    static let shared = CurrentAppState()
    
    private var sourceCurrentCurrency: [String: String]
    private var destinyCurrentCurrency: [String: String]
    private var quotes: [String: Double]
    typealias quote = [String: Double]
    
    private init() {
        sourceCurrentCurrency = ["BRL": "Real"]
        destinyCurrentCurrency = ["USD": "Dollar"]
        quotes = ["USDBRL": 5.31, "USDEUR": 0.84]
    }
    
    func getSourceCurrentCurrency() -> [String: String] {
        return sourceCurrentCurrency
    }
    
    func getDestinyCurrentCurrency() -> [String: String] {
        return destinyCurrentCurrency
    }
    
    func setSourceCurrentCurrency(_ currency: [String: String]) {
        sourceCurrentCurrency = currency
    }
    
    func setDestinyCurrentCurrency(_ currency: [String: String]) {
        destinyCurrentCurrency = currency
    }
    
    func setQuote(_ quote: quote) {
        self.quotes = quote
    }
    
    func getSourceCurrentCurrencyQuote() -> Double {
        let quoteValue = quotes.filter { key, value -> Bool in
            key == "USD\(Array(sourceCurrentCurrency)[0].key)"
        }
        let sourceValue = Array(quoteValue)[0].value
        return sourceValue
    }
    
    func getDestinyCurrentCurrencyQuote() -> Double {
        let quoteValue = quotes.filter { key, value -> Bool in
            key == "USD\(Array(destinyCurrentCurrency)[0].key)"
        }
        let destinyValue = Array(quoteValue)[0].value
        return destinyValue
    }

}
