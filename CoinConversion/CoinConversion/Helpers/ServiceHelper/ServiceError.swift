//
//  ServiceError.swift
//  CoinConversion
//
//  Created by Ronilson Batista on 18/07/20.
//  Copyright © 2020 Ronilson Batista. All rights reserved.
//

import Foundation

// MARK: - ServiceError
struct ServiceError {
    var type: RequestError
    var object: Any?
    
    init(type: RequestError, object: Any? = nil) {
        self.type = type
        self.object = object
    }
    
    enum RequestError {
        case noAuthorized
        case notFound
        case timeOut
        case invalidUrl
        case invalidResponse
        case notMapped
        case noConnection
        
        var code: Int {
            switch self {
            case .noAuthorized: return 403
            case .notFound: return 404
            case .timeOut: return 504
            default: return 0
            }
        }
        
        var description: String {
            switch self {
            case .noAuthorized: return "Solicitação não autorizada"
            case .notFound: return "Recurso solicitado não encontrado"
            case .timeOut: return "Tempo de comunicação com o servidor excedido"
            case .invalidUrl: return "URL inválida"
            case .invalidResponse: return "Resposta inválida"
            case .noConnection: return "Encontramos problemas com a conexão. Tente ajustá-la para continuar navegando."
            default: return "Falha na comunicação com o servidor"
            }
        }
        
        init(code: Int) {
            switch code {
            case 403: self = .noAuthorized
            case 404: self = .notFound
            case 504: self = .timeOut
            default: self = .notMapped
            }
        }
    }
}
