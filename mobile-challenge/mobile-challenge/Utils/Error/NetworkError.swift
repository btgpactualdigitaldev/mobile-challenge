//
//  NetworkError.swift
//  mobile-challenge
//
//  Created by Murilo Teixeira on 26/09/20.
//

import Foundation

enum NetworkError: Error {
    case offline,
         unknowError,
         invalidResponseType,
         objectNotDecoded,
         connectionError
}

extension NetworkError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .offline: return "Conexão com a internet offline."
        case .unknowError: return "Erro de conexão desconhecido."
        case .invalidResponseType: return "Tipo de dados retornado é inválido."
        case .objectNotDecoded: return "O objeto retornado não pôde ser decodificado."
        case .connectionError: return "Problema na conexão"
        }
    }
}
