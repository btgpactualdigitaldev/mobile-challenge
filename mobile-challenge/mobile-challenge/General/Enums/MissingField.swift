//
//  MissingField.swift
//  mobile-challenge
//
//  Created by Caio Azevedo on 28/11/20.
//

import Foundation

enum MissingField {
    case buttons
    case textField
    
    var title: String {
        switch self {
        case .buttons:
            return "Escolha suas Moedas"
        case .textField:
            return "Adicione o valor"
        }
    }
    
    var menssage: String {
        switch self {
        case .buttons:
            return "Você precisa selecionar uma moeda de origem e destino para realizar a conversão."
        case .textField:
            return "Você precisa adicionar um valor para realizar a conversão."
        }
    }
}
