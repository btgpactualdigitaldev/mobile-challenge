//
//  CurrencyError.swift
//  mobile-challenge
//
//  Created by Caio Azevedo on 28/11/20.
//

import Foundation

enum CurrencyError: Error {
    case NoNetworkConnnectionError
    case APIConnectionError
    case InvalidURL
    case DecodeError
    case ResponseError
    case UnknowError
    case CoreDataError
    
    var localizedError: String {
        switch self {
        case .NoNetworkConnnectionError:
            return "O dispositivo não está conectado a Internet."
        case .APIConnectionError:
            return "Conexão com a API."
        case .InvalidURL:
            return "URL inválida."
        case .DecodeError:
            return "Decodificação dos dados da API."
        case .ResponseError:
            return "Dados recebidos da API são inválidos."
        case .UnknowError:
            return "Erro Desconhecido."
        case .CoreDataError:
            return "Erro de Acesso ao Banco de dados local."
        }
    }
}
