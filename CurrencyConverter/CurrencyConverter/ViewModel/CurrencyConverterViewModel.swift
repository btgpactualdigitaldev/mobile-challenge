//
//  CurrencyConverterViewModel.swift
//  CurrencyConverter
//
//  Created by Isnard Silva on 02/12/20.
//

import Foundation

class CurrencyConverterViewModel {
    // MARK: - Properties
    private var sourceCurrency: Currency?
    private var targetCurrency: Currency?
    private var valueToConvert: Double = 0.0
    
    
    // MARK: - Input Methods
    func insertSourceCurrency(currency: Currency) {
        self.sourceCurrency = currency
    }
    
    func insertTargetCurrency(currency: Currency) {
        self.targetCurrency = currency
    }
    
    func insertValueToConvert(value: Double) {
        self.valueToConvert = value
    }
    
    
    // MARK: - Convert Method
    func convertCurrencies() throws -> Double {
        guard let validSourceCurrency = self.sourceCurrency else {
            throw CurrencyConverterError.emptySourceCurrency
        }
        
        guard let validTargetCurrency = self.targetCurrency else {
            throw CurrencyConverterError.emptyTargetCurrency
        }
        
        guard valueToConvert != 0 else {
            throw CurrencyConverterError.emptyValueToConvert
        }
        
        let resultOfConversion = valueToConvert / validSourceCurrency.valueInDollar * validTargetCurrency.valueInDollar
        
        return resultOfConversion
    }
}
