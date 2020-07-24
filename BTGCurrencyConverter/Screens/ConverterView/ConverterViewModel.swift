//
//  ConverterViewModel.swift
//  BTGCurrencyConverter
//
//  Created by Ian McDonald on 22/07/20.
//  Copyright © 2020 Ian McDonald. All rights reserved.
//

import Foundation

class ConverterViewModel {
    static let shared = ConverterViewModel()
    var quotes: Quotes? {
        didSet {
            if let quotes = quotes {
                PersistenceController.updateQuotes(quotes)
            }
        }
    }
    
    private init() {
        PersistenceController.retreiveQuotes { [weak self] quotes in
                self?.quotes = quotes
        }
    }
    
    func convertValue(from baseCurrency: String, to targetCurrency: String, amount: String,
                 completed: @escaping (String) -> Void) {
        if let notVerified = verifyCurrencies(from: baseCurrency, to: targetCurrency) {
            completed(notVerified)
        }
        
        if quotes?.isValid ?? false {
            completed(convert(from: baseCurrency, to: targetCurrency, amount: amount))
        } else {
            NetworkController.shared.getLiveConversion { [weak self] result in
                guard let self = self else {
                    completed(BTGConversionError.unableToConvert.rawValue)
                    return
                }
                
                switch result {
                case .success(let liveQuotes):
                    let newQuotes = Quotes(list: liveQuotes.quotes)
                    self.quotes = newQuotes
                    completed(self.convert(from: baseCurrency, to: targetCurrency, amount: amount))
                case .failure(let error):
                    if let _ = self.quotes {
                        completed(self.convert(from: baseCurrency, to: targetCurrency,
                                               amount: amount))
                    } else {
                        completed(error.rawValue)
                    }
                }
            }
        }
    }
    
    private func verifyCurrencies(from baseCurrency: String, to targetCurrency: String) -> String? {
        guard baseCurrency.count == 3 else {
                return BTGConversionError.baseCurrencyInvalid.rawValue
        }
        
        guard targetCurrency.count == 3 else {
            return BTGConversionError.targetCurrencyInvalid.rawValue
        }
        
        return nil
    }
    
    private func convert(from baseCurrency: String?, to targetCurrency: String?,
                         amount: String?) -> String {
        guard let baseCurrency = baseCurrency, let targetCurrency = targetCurrency,
            let amount = amount, let amountDouble = Double(amount)  else {
                return BTGConversionError.unableToConvert.rawValue
        }
        
        var convertedAmount: Double = 0
        
        if baseCurrency == BaseCurrency.base.rawValue {
            guard let convertedValue = convertFromBase(to: targetCurrency,
                                                      amount: amountDouble) else {
                return BTGConversionError.unableToConvert.rawValue
            }
            convertedAmount = convertedValue
        } else if targetCurrency == BaseCurrency.base.rawValue {
            guard let convertedValue = convertToBase(currency: baseCurrency,
                                                    amount: amountDouble) else {
                return BTGConversionError.unableToConvert.rawValue
            }
            convertedAmount = convertedValue
        } else {
            guard let convertToBase = convertToBase(currency: baseCurrency,
                                                  amount: amountDouble) else {
                return BTGConversionError.unableToConvert.rawValue
            }
            
            guard let convertedValue = convertFromBase(to: targetCurrency,
                                                     amount: convertToBase) else {
                return BTGConversionError.unableToConvert.rawValue
            }
            convertedAmount = convertedValue
        }
        
        return String(format: StringFormat.twoDecimalPlaces.rawValue,convertedAmount)
    }
    
    private func convertToBase(currency: String, amount: Double) -> Double? {
        let conversionString = BaseCurrency.base.rawValue + currency
        guard let conversionRate = quotes?.list[conversionString] else {
            return nil
        }
        
        return 1/conversionRate * amount
    }
    
    private func convertFromBase(to currency: String, amount: Double) -> Double? {
        let conversionString = BaseCurrency.base.rawValue + currency
        guard let conversionRate = quotes?.list[conversionString] else {
            return nil
        }
        
        return conversionRate * amount
    }
}
