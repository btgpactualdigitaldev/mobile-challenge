//
//  ErrorHandler.swift
//  mobile-challenge
//
//  Created by Brunno Andrade on 04/10/20.
//

import Foundation

enum ErrorHandler: String, Error {
    case emptyOriginSelected = "Escolha uma origem para continuar."
    case emptyDestinySelected = "Escolha um destino para continuar."
    case zeroValueError = "Digite um valor maior que 0 para continuar."
    case invalidValue = "Digite um valor válido para continuar."
    case converterError = "Não foi possivel fazern a conversão dos valores."
    case notFound = "Não encontrado"
}

enum ErrorNetwork: String, Error {
    case decodingError = "Erro Decoding"
    case urlError = "URL inválido"
    case connectionError = "Erro de conexão"
    case failure = "Erro desconhecido"
}
