//
//  CurrencyConverterViewModel.swift
//  BTGTesteChallenge
//
//  Created by Rafael  Hieda on 2/5/20.
//  Copyright © 2020 Rafael_Hieda. All rights reserved.
//

import Foundation

protocol CurrencyConverterViewModelProtocol: class {
    var liveCurrencyRepository: LiveCurrencyRepositoryProtocol? { get }
    var listCurrencyRepository: ListCurrencyRepositoryProtocol? { get }
    var isSourceSelected: Bool {get set}
    var selectedSourceCurrency: String {get set}
    var selectedConversionCurrency: String {get set}
    var currencyList: [(key: String, value: String)] { get }
    var currencyDictionary: [String : String] { get set }
    var currencyRatesDictionary: [String : Double] { get set }
    var delegate: PresentErrorDelegate { get }
    
    func totalOfCurrenciesInList() -> Int
    func requestCurrencyRates()
    func requestCurrencyList()
    func performConversion(value: String) -> Double
    func getUSDCurrencyRateForSource() -> Double
    func getUSDCurrencyRateForDestination() -> Double
}

class CurrencyConverterViewModel: CurrencyConverterViewModelProtocol {
    
    var liveCurrencyRepository: LiveCurrencyRepositoryProtocol?
    var listCurrencyRepository: ListCurrencyRepositoryProtocol?
    var selectedSourceCurrency: String = "USD"
    var selectedConversionCurrency: String = "USD"
    var currencyDictionary: [String : String] = [:]
    var currencyRatesDictionary: [String : Double] = [:]
    var isSourceSelected: Bool = false
    var delegate: PresentErrorDelegate
    
    var currencyList: [(key: String, value: String)] {
        DictionarySortHelper.sortAscending(for: currencyDictionary)
    }
    
    init(liveCurrencyRepository: LiveCurrencyRepositoryProtocol, listCurrencyRepository: ListCurrencyRepositoryProtocol, presentErrorDelegate: PresentErrorDelegate) {
        self.liveCurrencyRepository = liveCurrencyRepository
        self.listCurrencyRepository = listCurrencyRepository
        self.delegate = presentErrorDelegate
    }
    
    func totalOfCurrenciesInList() -> Int {
        return currencyDictionary.count
    }
    
    func getUSDCurrencyRateForSource() -> Double {
        return currencyRatesDictionary["USD\(selectedSourceCurrency)"] ?? 0.00
    }
    
    func getUSDCurrencyRateForDestination() -> Double {
        return currencyRatesDictionary["USD\(selectedConversionCurrency)"] ?? 0.00
    }
    
    func requestCurrencyRates() {
        liveCurrencyRepository?.fetchLiveCurrency(completionHandler: { [weak self] (result) in
            switch result {
            case .success(let currencyRate):
                guard let quotes = currencyRate.quotes else {
                    return
                }
                self?.currencyRatesDictionary = quotes
            case .error(let error):
                self?.delegate.present(error: error.localizedDescription)
            }
        })
    }
    
    func requestCurrencyList() {
        listCurrencyRepository?.fetchListOfCurrency(completionHandler: { [weak self] (result) in
            switch result {
            case .success(let currencyList):
                guard let currencies = currencyList.currencies else { return }
                self?.currencyDictionary = currencies
            case .error(let error):
                self?.delegate.present(error: error.localizedDescription)
            }
        })
    }
    
    func performConversion(value: String) -> Double {
        guard let numericValue = Double(value) else { return 0.0 }
        let convertedValue = (numericValue * getUSDCurrencyRateForDestination()) / getUSDCurrencyRateForSource()
        return (convertedValue.isInfinite || convertedValue.isNaN) ? 0.00 : convertedValue
    }
}



