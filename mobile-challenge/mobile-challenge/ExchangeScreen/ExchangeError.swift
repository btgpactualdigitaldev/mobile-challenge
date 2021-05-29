//
//  ExchangeError.swift
//  mobile-challenge
//
//  Created by Bernardo Nunes on 23/11/20.
//

import Foundation

enum ExchangeError: Error {
    case emptyValue
    case emptyFrom
    case emptyTo
    
    var errorDescription: String? {
        switch self {
        case .emptyValue: return "Preencha o campo de valor."
        case .emptyFrom: return "Escolha uma moeda de origem."
        case .emptyTo: return "Escolha uma moeda de destino."
        }
    }
}
