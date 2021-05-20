//
//  CurrenciesViewModel.swift
//  DesafioBTG
//
//  Created by Any Ambria on 12/12/20.
//  Copyright © 2020 Any Ambria. All rights reserved.
//

import Foundation
import UIKit

class CurrenciesViewModel {
    var currenciesProvider: CurrenciesProviderProtocol?
    
    var currencies: [(String, String)] = []
    var quotes: [(String, Double)] = []
    var errorList = Bindable<Bool>(false)
    var errorQuotes = Bindable<Bool>(false)
    var viewController: UIViewController
    
    init(currenciesProvider: CurrenciesProviderProtocol?, viewController: UIViewController) {
        self.currenciesProvider = currenciesProvider
        self.viewController = viewController
    }
    
    func fetchListCurrencies() {
        Loading().show(viewController: viewController)
        currenciesProvider?.fetchListCurrencies(completionHandler: { (result) in
            Loading().hide()
            switch result {
            case .success(let obj):
                if let success = obj.success, success {
                    self.formatterCurrencies(dictionary: obj.currencies ?? [:])
                    self.errorList.value = false
                } else {
                    self.errorList.value = true
                }
            case .error:
                self.errorList.value = true
            }
        })
    }
    
    private func formatterCurrencies(dictionary: [String: String]) {
        currencies = []
        for (key, value) in dictionary {
            currencies.append((key, value))
        }
        currencies = currencies.sorted(by: { $0.1 < $1.1 })
    }
    
    func fetchQuotesCurrencies() {
        Loading().show(viewController: viewController)
        currenciesProvider?.fetchQuotesCurrencies(completionHandler: { (result) in
            Loading().hide()
            switch result {
            case .success(let obj):
                if let success = obj.success, success {
                    self.formatterQuotes(dictionary: obj.quotes ?? [:])
                    self.errorQuotes.value = false
                } else {
                    self.errorQuotes.value = true
                }
            case .error:
                self.errorQuotes.value = true
            }
        })
    }
    
    private func formatterQuotes(dictionary: [String: Double]) {
        quotes = []
        for (key, value) in dictionary {
            quotes.append((key, value))
        }
        quotes = quotes.sorted(by: { $0.0 < $1.0 })
    }
    
    func convertCurrencies(value: Double, firstCurrency: Double, for secondCurrency: Double) -> String {
        let convert = (value / firstCurrency) * secondCurrency
        return String(format: "%.2f", convert)
    }
}
