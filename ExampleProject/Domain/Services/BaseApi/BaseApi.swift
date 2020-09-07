//
//  BaseApi.swift
//  ExampleProject
//
//  Created by Lucas Mathielo Gomes on 03/09/20.
//  Copyright © 2020 Lucas Mathielo Gomes. All rights reserved.
//

import Foundation

enum ApiResponse<T> {
    case success(T)
    case failure(ApiError)
}

protocol ApiCall: Decodable {
    var success: Bool { get set }
    var error: ApiError? { get set }
}

class ApiError: Decodable {
    let code: CurrencyApiErrors?
    let type: String?
    let info: String?
    
    init(_ code: CurrencyApiErrors) {
        self.code = code
        self.type = ""
        self.info = ""
    }
}

enum CurrencyApiErrors: Int, Decodable {
    case unknown
    case parseFailed
    case notFound = 404
    case unauthorized = 101
    case inactiveAccount = 102
    case nonExistent = 103
    case excedeed = 104
    case subscriptionNotSuported = 105
    case noResults = 106
    
    func friendlyCode() -> String {
        switch self {
        case .unknown:
            return "Erro desconhecido. Por favor, tente novamente."
        case .parseFailed:
            return "Houve um problema ao recuperar os dados. Por favor, tente novamente"
        case .notFound:
            return "Houve um problema ao se conectar com o servidor. Por favor, tente novamente"
        case .unauthorized:
            return "Você não tem permissão para acessar essa funcionalidade."
        case .inactiveAccount:
            return "Sua conta não está ativa."
        case .nonExistent:
            return "Houve um problema ao se conectar com o servidor. Por favor, tente novamente"
        case .excedeed:
            return "Você excedeu o limite mensal de acessos."
        case .subscriptionNotSuported:
            return "Sua conta não possui permissão para acessar essa funcionalidade."
        case .noResults:
            return "O serviço nao retornou resultados."
        }
    }
}
