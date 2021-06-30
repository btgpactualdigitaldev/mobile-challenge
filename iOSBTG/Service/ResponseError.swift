//
//  ResponseError.swift
//  iOSBTG
//
//  Created by Filipe Merli on 10/06/20.
//  Copyright © 2020 Filipe Merli. All rights reserved.
//

import Foundation

public enum ResponseError: Error {
    case generic
    case rede
    case decoding
    
    var reason: String {
        switch self {
        case .rede:
            return "Ocorreu um erro ao receber os dados da rede. Verifique sua conexão e arraste a tela para baixo para atualizar"
        case .decoding:
            return "Ocorreu um erro ao decodificar os dados da rede. Tente novamente mais tarde."
        case .generic:
            return "Ocorreu um erro inesperado."
        }
    }
}
