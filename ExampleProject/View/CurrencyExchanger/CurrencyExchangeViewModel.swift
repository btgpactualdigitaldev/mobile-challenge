//
//  CurrencyExchangeViewController.swift
//  ExampleProject
//
//  Created by Lucas Mathielo Gomes on 03/09/20.
//  Copyright © 2020 Lucas Mathielo Gomes. All rights reserved.
//

import Foundation

enum SelectedButton: Int {
    case actualCurrency = 0
    case currencyToExchange
}

class CurrencyExchangeViewModel {
    var selectedButton: SelectedButton = .actualCurrency
    var actualCurrency: Currency?
    var selectedCurrency: Currency?
    var actualCurrencyValue: Double?
    var convertedCurrencyValue: Double?
    
    func setActualCurrency(_ currency: Currency) {
        self.actualCurrency = currency
    }
    
    func setSelectedCurrency(_ currency: Currency) {
        self.selectedCurrency = currency
    }
    
    func isValidToCalculate() -> Bool {
        return actualCurrency != nil && selectedCurrency != nil && actualCurrencyValue != nil
    }
    
    fileprivate func updateConvertedCurrency(selectedCurrency: Double, currencyExchange: Double) {
        let myValueDollar = (self.actualCurrencyValue ?? 0)/selectedCurrency
        let exchangeValue = myValueDollar * currencyExchange
        convertedCurrencyValue = exchangeValue
    }
}

extension CurrencyExchangeViewModel {
    func calculate(callback: @escaping (ApiError?) -> Void) {
        CurrencyService<CurrencyRatesList>.live.http({ [weak self] response in
            guard let wSelf = self else { return }
            switch response {
            case .success(let curr):
                
                guard let rates = curr.rates else { return callback(nil) }
                
                let selectedCurrency = rates.first(where: { String($0.initials.suffix(3)) == wSelf.actualCurrency?.initials })
                let currencyExchange = rates.first(where: { String($0.initials.suffix(3)) == wSelf.selectedCurrency?.initials })
                
                wSelf.updateConvertedCurrency(selectedCurrency: selectedCurrency?.rate ?? 0, currencyExchange: currencyExchange?.rate ?? 0)
                callback(nil)
            case .failure(let err):
                callback(err)
            }
        })
    }
}
