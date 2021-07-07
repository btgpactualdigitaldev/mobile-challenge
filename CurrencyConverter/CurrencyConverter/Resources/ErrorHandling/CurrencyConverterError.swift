//
//  CurrencyConverterError.swift
//  CurrencyConverter
//
//  Created by Isnard Silva on 02/12/20.
//

import Foundation

enum CurrencyConverterError {
    case emptySourceCurrency
    case emptyTargetCurrency
    case emptyValueToConvert
    case invalidValueToConvert
}

// MARK: - LocalizedError
extension CurrencyConverterError: LocalizedError {
    var errorDescription: String? {
        switch self {
        
        case .emptySourceCurrency:
            return "É necessário inserir a moeda de origem."
        case .emptyTargetCurrency:
            return "É necessário inserir a moeda de destino."
        case .emptyValueToConvert:
            return "É necessário inserir o valor a ser convertido."
        case .invalidValueToConvert:
            return "Valor inválido!"
        }
    }
}
