//
//  CurrencyViewModel.swift
//  mobile-challenge
//
//  Created by Matheus Brasilio on 25/10/20.
//  Copyright © 2020 Matheus Brasilio. All rights reserved.
//

import Foundation

public class CurrencyViewModel {
    // MARK: - Attributes
    var currencyList: [Currency]?
    var currencyListConvertedToDollar: [CurrencyDollarValue]?
    var selectedOriginCurrencySymbol: String?
    var selectedTargetCurrencySymbol: String?
    var amount: Double = 0.0
    let currencyApi = CurrencyApi()
    let source: String = "USD"
    
    init() {}
    
    public func populateCurrencyList(action: @escaping () -> Void) {
        currencyApi.getCurrencyList() { [weak self] list in
            guard let wSelf = self else { return }
            wSelf.currencyList = list
            action()
        }
    }
    
    public func enableConvertButton() -> Bool {
        guard let _ = selectedOriginCurrencySymbol, let _ = selectedTargetCurrencySymbol else { return false }
        return true
    }
    
    public func convertCurrencyValue(action: @escaping (String?) -> Void) {
        guard let originalSymbol = selectedOriginCurrencySymbol, let targetSymbol = selectedTargetCurrencySymbol else { return }
        var formattedTotalAmount: String? = nil
        if originalSymbol == targetSymbol {
            formattedTotalAmount = self.amount.formatCurrency(currencySymbol: originalSymbol)
            action(formattedTotalAmount)
        } else {
            if let list = currencyListConvertedToDollar {
                formattedTotalAmount = self.getConvertedValue(originalSymbol, targetSymbol, currencyListConvertedToDollar: list)
                action(formattedTotalAmount)
            } else {
                self.getCurrencyListConvertedToDollar() { [weak self] in
                    guard let wSelf = self else { return }
                    if let list = wSelf.currencyListConvertedToDollar {
                        formattedTotalAmount = wSelf.getConvertedValue(originalSymbol, targetSymbol, currencyListConvertedToDollar: list)
                        action(formattedTotalAmount)
                    }
                }
            }
        }
    }
    
    fileprivate func getConvertedValue(_ originalSymbol: String, _ targetSymbol: String, currencyListConvertedToDollar list: [CurrencyDollarValue]) -> String? {
        let formattedTargetValue = source + targetSymbol, formattedOriginalValue = source + originalSymbol
        if originalSymbol == self.source {
            let convertedCurrency = list.filter{ $0.symbol == formattedTargetValue }.first
            if let convertedCurrency = convertedCurrency {
                return (convertedCurrency.dollarQuotation * self.amount).formatCurrency(currencySymbol: targetSymbol)
            }
        } else if targetSymbol == self.source {
            let originalConvertedCurrency = list.filter{ $0.symbol == formattedOriginalValue }.first
            if let originalConvertedCurrency = originalConvertedCurrency {
                return (self.amount / originalConvertedCurrency.dollarQuotation).formatCurrency(currencySymbol: targetSymbol)
            }
        } else {
            let originalConvertedCurrency = list.filter{ $0.symbol == formattedOriginalValue }.first, targetConvertedCurrency = list.filter{ $0.symbol == formattedTargetValue }.first
            if let originalConvertedCurrency = originalConvertedCurrency, let targetConvertedCurrency = targetConvertedCurrency {
                let dollarOriginalValue: Double = self.amount / originalConvertedCurrency.dollarQuotation
                return (targetConvertedCurrency.dollarQuotation * dollarOriginalValue).formatCurrency(currencySymbol: targetSymbol)
            }
        }
        return nil
    }
    
    fileprivate func getCurrencyListConvertedToDollar(action: @escaping () -> Void) {
        currencyApi.getCurrencyListConvertedToDollar() { [weak self] list in
            guard let wSelf = self else { return }
            wSelf.currencyListConvertedToDollar = list
            action()
        }
    }
    
}
