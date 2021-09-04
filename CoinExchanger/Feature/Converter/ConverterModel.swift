//
//  ConverterModel.swift
//  CoinExchanger
//
//  Created by Edson Rottava on 03/09/21.
//

import UIKit

class ConverterModel: UIControl {
    var origin: String = userPrefs.origin { didSet { userPrefs.origin = origin } }
    var target: String  = userPrefs.target { didSet { userPrefs.target = target } }
        
    var data = Storage.retrieve(Constants.quoteFile, from: .caches, as: GetRatesResponse.self)
        ?? GetRatesResponse(false, Constants.code, [:])
    
    var fetchCompletion: () -> Void = {}
    
    func fetchCoins() {
        Repository.getCoins(completion: fetchCoinsCompletion)
    }
    
    func fetchQuotes() {
        Repository.getQuotes(completion: fetchQuotesCompletion)
    }
    
    func appraise(_ value: Double) -> Double {
        return appraise(value, from: origin, to: target)
    }
    
    func appraise(_ value: Double, from origin: String, to target: String) -> Double {
        let oQuote = (data.source ?? Constants.code) + (origin)
        let tQuote = (data.source ?? Constants.code) + (target)
        return value / (data.quotes?[oQuote] ?? 1.0) * (data.quotes?[tQuote] ?? 1)
    }
}

private extension ConverterModel {
    func fetchCoinsCompletion(_ response: GetCoinsResponse?, _ error: Error?) {
        if (response?.success ?? false || DEBUG) {
            if let items = response {
                Storage.store(items, to: .caches, as: Constants.coinFile)
            } else {
                Toast.show(message: L10n.System.Error.storage)
            }
        } else {
            Toast.show(message: L10n.System.Error.connection)
        }
        
        fetchCompletion()
    }
    
    func fetchQuotesCompletion(_ response: GetRatesResponse?, _ error: Error?) {
        if (response?.success ?? false || DEBUG) {
            if let data = response {
                self.data = data
                Storage.store(data, to: .caches, as: Constants.quoteFile)
                userPrefs.date = Helper.getDate(Date())
            } else {
                Toast.show(message: L10n.System.Error.storage)
            }
        } else {
            Toast.show(message: L10n.System.Error.connection)
        }
        
        fetchCompletion()
    }
}
