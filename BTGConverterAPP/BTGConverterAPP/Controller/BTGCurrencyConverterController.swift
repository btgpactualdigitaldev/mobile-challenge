//
//  BTGCurrencyConverterVCController.swift
//  BTGConverterAPP
//
//  Created by Ana Caroline de Souza on 15/05/20.
//  Copyright © 2020 Leonardo Maia Pugliese. All rights reserved.
//

import Foundation

protocol CurrencyConverterController {
    func getCurrencyConversion(baseCurrency: String, targetCurrency: String, inputBaseDecimal: Decimal)
    func validateUserInput(userValueInput: String?, baseCurrency: String? , targetCurrency: String?) -> Bool
}

struct BTGCurrencyConverterController: CurrencyConverterController {
    
    weak var view : CurrencyResultHandler?
    var quotesController = BTGCurrencyQuotesController()
    var baseCurrencyAbbreviation =  BTGCurrencyQuotesConstants.baseCurrencyAbbreviation.rawValue
    
    init(view: CurrencyResultHandler) {
        self.view = view
        quotesController.loadQuotes()
    }
    
    func getCurrencyConversion(baseCurrency: String, targetCurrency: String, inputBaseDecimal: Decimal) {
        print("\(baseCurrency) + \(targetCurrency) + \(inputBaseDecimal)")
        
        if quotesController.getQuotes() == nil {
            quotesController.loadQuotes()
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
                currencyResult = BTGCurrencyOperationsController.currencyToUSDFormatted(inputBaseDecimal: inputBaseDecimal, to: quotesToUsd)
            case .fromBaseType:
                guard let dolartoTargetQuote = quotes[baseCurrencyAbbreviation+targetCurrency] else {
                    view?.showErrorMessage(message: BTGCurrencyErrorConstants.currencyPairNotFound.rawValue)
                    return
                }
                currencyResult = BTGCurrencyOperationsController.baseCurrencytoTarget(dolarQuantity: inputBaseDecimal,
                                                                                 to: dolartoTargetQuote)
            case .noBaseTypeConversion:
                
                guard let quotesToUsd = quotes[baseCurrencyAbbreviation+baseCurrency], let dolartoTargetQuote = quotes[baseCurrencyAbbreviation+targetCurrency]  else {
                    view?.showErrorMessage(message: BTGCurrencyErrorConstants.currencyPairNotFound.rawValue)
                    return
                }
                let currencyResultToDolar = BTGCurrencyOperationsController.currencyToBaseCurrencyUnformatted(inputBaseDecimal: inputBaseDecimal, to: quotesToUsd)
                currencyResult = BTGCurrencyOperationsController.baseCurrencytoTarget(dolarQuantity: currencyResultToDolar, to: dolartoTargetQuote)
            }
            
            view?.setCurrencyConversionResult(currencyConvertedResult: "\(currencyResult) \(targetCurrency)")
        } else {
            view?.showErrorMessage(message: quotesController.getLastError())
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
        CharacterSet.decimalDigits.isSuperset(of: CharacterSet(charactersIn: userValueInput))
        
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


