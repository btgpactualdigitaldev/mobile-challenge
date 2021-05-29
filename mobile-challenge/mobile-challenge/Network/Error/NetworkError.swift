//
//  NetworkError.swift
//  mobile-challenge
//
//  Created by Bernardo Nunes on 22/11/20.
//

import Foundation

enum NetworkError: Error {
    case deviceOffline
    case unknownError
    case invalidURL
    case APIError
    case decodeFailure
    
    var errorDescription: String? {
        switch self {
        case .deviceOffline: return "Dispositivo sem conexão. Os dados podem estar desatualizados."
        case .unknownError: return "Ocorreu um erro. Os dados podem estar desatualizados."
        case .APIError: return "Erro na requisição. Os dados podem estar desatualizados."
        case .decodeFailure: return "Erro na intrepretação de dados. Os dados podem estar desatualizados."
        case .invalidURL: return "URL inválida. Os dados podem estar desatualizados."
        }
    }
}
