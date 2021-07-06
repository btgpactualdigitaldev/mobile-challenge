//
//  ExchangeError.swift
//  CurrencyExchange
//
//  Created by Carlos Fontes on 01/11/20.
//

import Foundation

enum ExchangeError: Error {
    case exchangeValueCannotBeUnwrapped
    case currencyCannotBeUnwrapped
    case currenciesAreEqual
    case unknown
}

extension ExchangeError: ErrorDescriptable {
    var description: String {
        switch self {
        
        case .exchangeValueCannotBeUnwrapped:
            return "Houve algum erro no valor informado! Por favor tente novamente..."
        case .currencyCannotBeUnwrapped:
            return "Erro ao tentar desembrulhar alguma moeda, por favor verifique se as duas moedas foram selecionadas."
        case .currenciesAreEqual:
            return "Por favor verifique se você selecionou moedas iguais para origem e destino"
        case .unknown:
            return "Verifique se todos os dados foram preenchidos."
        }
    }
    
    
}
