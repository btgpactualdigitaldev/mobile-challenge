//
//  CurrencyConverterViewModel.swift
//  Mobile Challenge
//
//  Created by Daive Costa Nardi Simões on 23/09/21.
//

import Foundation

final class ConverterViewModel {
    
    // MARK: - Public properties
    
    var sourceCurrency: String?
    var targetCurrency: String?
    
    // MARK: - Private properties
    
    private var converterUseCase: ConverterUseCase
    
    // MARK: - Bind properties
    
    private var convertedValue: Double? {
        didSet {
            guard let convertedValue = convertedValue else { return }
            NotificationCenter.default.post(name: NSNotification.Name(Constants.ConverterNotificationName.rawValue), object: convertedValue)
        }
    }
    
    private var conversionError: Error? {
        didSet {
            guard let conversionError = conversionError else { return }
            NotificationCenter.default.post(name: NSNotification.Name(Constants.ConversionErrorNotificationName.rawValue), object: conversionError)
        }
    }
    
    // MARK: - Initializer
    
    init(converterUseCase: ConverterUseCase) {
        self.converterUseCase = converterUseCase
    }
    
    // MARK: - Public methods
    
    func convert(value: Double) {
        guard let sourceCurrency = sourceCurrency, let targetCurrency = targetCurrency else { return }
        converterUseCase.convert(value: value, from: sourceCurrency, to: targetCurrency) { result, error in
            if let error = error {
                self.conversionError = error
                return
            }
            
            self.convertedValue = result
        }
    }

}

