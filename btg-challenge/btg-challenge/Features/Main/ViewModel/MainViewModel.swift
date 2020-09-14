//
//  MainViewModel.swift
//  btg-challenge
//
//  Created by Wesley Araujo on 13/09/20.
//  Copyright © 2020 Wesley Araujo. All rights reserved.
//

import UIKit

protocol MainViewModelDelegate {
    func didGetQuotesCurrency(_ quotes: Live)
    func didGetError(_ error: Error)
}

class MainViewModel: ViewModel {
    
    var viewController: UIViewController?
    var service: MainService = MainService()
    var live: Live?
    
    required init() {
        service.viewModel = self
        
        // For unit test
        live = Live(success: true,
                      terms: " ",
                      privacy: " ",
                      timestamp: 8777,
                      source: " ",
                      quotes: ["USDBRL": 5.31, "USDEUR": 0.84])
    }
    
    func setViewController(_ viewController: UIViewController) {
        self.viewController = viewController
    }
    
    func getQuotesCurrency() {
        service.getQuotesCurrency()
    }
    
    func getSourceCurrencyButtonTitle() {
        let sourceButtonTitle = "Moeda de Origem\n\(Array(CurrentAppState.shared.getSourceCurrentCurrency())[0].value)"
        let destinyButtonTitle = "Moeda de Destino\n\(Array(CurrentAppState.shared.getDestinyCurrentCurrency())[0].value)"
        (viewController as! ViewController).setButtonTitle(for: sourceButtonTitle, destinyButtonTitle: destinyButtonTitle)
    }
    
    func convertCurrency(from sourceCurrency: String, to destinyCurrency: String, withValue value: Double) -> Double? {
        let isNotConversionToDollar = sourceCurrency != "USD" && destinyCurrency != "USD"
        let isConversionDollar = destinyCurrency == "USD" ||  sourceCurrency == "USD"
        if isNotConversionToDollar {
            let currencySourceQuote = CurrentAppState.shared.getSourceCurrentCurrencyQuote()
            let destinyQuote = CurrentAppState.shared.getDestinyCurrentCurrencyQuote()
            let valueDollar = value.convertToDollar(by: currencySourceQuote)
            let convertedValue = valueDollar.convertDollarToCurrency(by: destinyQuote)
            return convertedValue
        } else if isConversionDollar {
            let convertedToDollar = value.convertToDollar(by: CurrentAppState.shared.getSourceCurrentCurrencyQuote())
            return convertedToDollar
        }
        return nil
    }
    
    func selectSourceCurrency(_ sourceCurrency: String) -> [String: Double]? {
        guard let value = live?.quotes?[sourceCurrency] else { return nil }
        return ["\(sourceCurrency)": value]
    }
    
    func selectDestinyCurrency(_ destinyCurrency: String) -> [String: Double]? {
        guard let value = live?.quotes?["USD\(destinyCurrency)"] else { return nil }
        return ["USD\(destinyCurrency)": value]
    }
    
    func selectCurrencyQuote(from currency: String) -> [String: Double]? {
        guard let quoteValue = live?.quotes?["USD\(currency)"] else { return nil }
        return ["USD\(currency)": quoteValue]
    }
    
    func setResultToView(value: Double) {
        let sourceCurrency = Array(CurrentAppState.shared.getSourceCurrentCurrency())[0].key
        let destinyCurrency = Array(CurrentAppState.shared.getDestinyCurrentCurrency())[0].key
        guard let result = convertCurrency(from: sourceCurrency, to: destinyCurrency, withValue: value) else { return }
        (viewController as! ViewController).setResult(result.rounded(toPlaces: 2))
    }
}

extension MainViewModel: MainViewModelDelegate {
    func didGetQuotesCurrency(_ quotes: Live) {
        guard let quotes = quotes.quotes else { return }
        CurrentAppState.shared.setQuote(quotes)
    }
    
    func didGetError(_ error: Error) {
        
    }
}


