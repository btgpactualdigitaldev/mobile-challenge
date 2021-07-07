//
//  NetworkError.swift
//  CurrencyConverter
//
//  Created by Isnard Silva on 02/12/20.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case networkUnavailable
    case connectionError
    case invalidResponseType
    case objectNotDecoded
    case unknowError
}


// MARK: - LocalizedError
extension NetworkError: LocalizedError {
    var errorDescription: String? {
        switch self {
        
        case .invalidURL:
            return "A URL é inválida!"
        case .networkUnavailable:
            return "Sem conexão!"
        case .connectionError:
            return "Houve algum problema na conexão com o servidor!"
        case .invalidResponseType:
            return "A resposta obtida pelo servidor é inválida!"
        case .objectNotDecoded:
            return "O objeto não pôde ser decodificado!"
        case .unknowError:
            return "Erro desconhecido"
        }
    }
}

