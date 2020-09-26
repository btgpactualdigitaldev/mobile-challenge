//
//  InputValueError.swift
//  mobile-challenge
//
//  Created by Murilo Teixeira on 26/09/20.
//

import Foundation

enum InputValueError: Error {
    case inputIsNil, inputIsEmpty, inputIsNotDouble, valueIsNegative
}

extension InputValueError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .inputIsNil: return "Valor não pode ser nulo"
        case .inputIsEmpty: return "Valor não pode ser vazio"
        case .inputIsNotDouble: return "Valor inserido é inválido"
        case .valueIsNegative: return "Valor não pode ser negativo"
        }
    }
}
