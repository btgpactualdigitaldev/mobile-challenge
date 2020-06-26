//
//  BTGCurrencyConverterVCController.swift
//  BTGConverterAPP
//
//  Created by Leonardo Maia Pugliese on 15/05/20.
//  Copyright © 2020 Leonardo Maia Pugliese. All rights reserved.
//

import Foundation

protocol CurrencyConverterController {
    func getCurrencyConversion(baseCurrency: String, targetCurrency: String, inputBaseDecimal: Decimal)
    func validateUserInput(userValueInput: String?, baseCurrency: String? , targetCurrency: String?) -> Bool
}

struct BTGCurrencyConverterController: CurrencyConverterController {
    
    weak var view : CurrencyResultHandler?
    private var quotesController = BTGCurrencyQuotesController()
    private var baseCurrencyAbbreviation =  BTGCurrencyQuotesConstants.baseCurrencyAbbreviation.rawValue
    
    init(view: CurrencyResultHandler) {
        self.view = view
        quotesController.loadQuotes()
        view.setLastTimeUpdated(date: quotesController.getLastTimeUpdatedFormatted())
    }
    
    func getCurrencyConversion(baseCurrency: String, targetCurrency: String, inputBaseDecimal: Decimal) {
        if quotesController.getQuotes() == nil {
            quotesController.loadQuotes()
            view?.setLastTimeUpdated(date: quotesController.getLastTimeUpdatedFormatted())
        }
        
        if let quotes = quotesController.getQuotes() {
            var currencyResult = ""
            switch BTGCurrencyOperationsController.getOperationType(baseCurrency: baseCurrency,
                                                                    targetCurrency: targetCurrency) {
            case .toBaseType:
                guard let quotesToUsd = quotes[baseCurrencyAbbreviation+baseCurrency] else {
                    view?.showErrorMessage(message: BTGCurrencyErrorConstants.currencyPairNotFound.rawValue)
                    return
                }
                currencyResult = BTGCurrencyOperationsController.currencyToBaseCurrencyFormatted(inputBaseDecimal: inputBaseDecimal, to: quotesToUsd)
            case .fromBaseType:
                guard let baseCurrencytoTargetQuote = quotes[baseCurrencyAbbreviation+targetCurrency] else {
                    view?.showErrorMessage(message: BTGCurrencyErrorConstants.currencyPairNotFound.rawValue)
                    return
                }
                currencyResult = BTGCurrencyOperationsController.baseCurrencytoTargetFormatted(
                    baseCurrencyQuantity: inputBaseDecimal, to: baseCurrencytoTargetQuote)
            case .noBaseTypeConversion:
                
                guard let quotesToBaseCurrency = quotes[baseCurrencyAbbreviation+baseCurrency],
                    let baseCurrencyToTargetQuote = quotes[baseCurrencyAbbreviation+targetCurrency]  else {
                        view?.showErrorMessage(message: BTGCurrencyErrorConstants.currencyPairNotFound.rawValue)
                        return
                }
                let currencyResultToBaseCurrency = BTGCurrencyOperationsController.currencyToBaseCurrencyUnformatted(
                    inputBaseDecimal: inputBaseDecimal, to: quotesToBaseCurrency)
                currencyResult = BTGCurrencyOperationsController.baseCurrencytoTargetFormatted(baseCurrencyQuantity: currencyResultToBaseCurrency, to: baseCurrencyToTargetQuote)
            }
            view?.setCurrencyConversionResult(currencyConvertedResult: "\(currencyResult) \(targetCurrency)")
            view?.setLastTimeUpdated(date: quotesController.getLastTimeUpdatedFormatted())
            
        } else {
            view?.showErrorMessage(message: quotesController.getLastError().isEmpty ? BTGCurrencyErrorConstants.unknown.rawValue : quotesController.getLastError())
        }
    }
    
    func validateUserInput(userValueInput: String?, baseCurrency: String? , targetCurrency: String?) -> Bool {
        
        guard let baseCurrency = baseCurrency , let targetCurrency = targetCurrency else {
            view?.showErrorMessage(message: BTGCurrencyErrorConstants.currenciesAreEmpty.rawValue)
            return false
        }
        
        if baseCurrency == targetCurrency {
            view?.showErrorMessage(message: BTGCurrencyErrorConstants.currenciesAreTheSame.rawValue)
            return false
        }
        
        guard let userValueInput = userValueInput else {
            view?.showErrorMessage(message: BTGCurrencyErrorConstants.currencyEmptyTextField.rawValue)
            return false
        }
        
        if Decimal(string: userValueInput) != nil &&
            CharacterSet.decimalDigits.isSuperset(of: CharacterSet(charactersIn: userValueInput)) {
            return true
        } else if userValueInput.isEmpty {
            view?.showErrorMessage(message: BTGCurrencyErrorConstants.currencyEmptyTextField.rawValue)
            return false
        } else {
            view?.showErrorMessage(message: BTGCurrencyErrorConstants.invalidCurrency.rawValue)
            return false
        }
    }
}


