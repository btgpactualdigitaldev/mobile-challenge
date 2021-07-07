//
//  CurrencyAPIError.swift
//  CurrencyConverter
//
//  Created by Isnard Silva on 02/12/20.
//

import Foundation

enum CurrencyAPIError {
    case invalidCurrencyName
    case invalidCurrencyValue
    case emptyCurrencyArray
}


// MARK: - LocalizedError
extension CurrencyAPIError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .invalidCurrencyName:
            return "Nome de moeda inválido detectado."
        case .invalidCurrencyValue:
            return "Valor de moeda inválido detectado."
        case .emptyCurrencyArray:
            return "Array de moedas está vazio"
        }
    }
}
