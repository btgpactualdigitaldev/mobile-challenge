//
//  CurrencyViewModelExtensions.swift
//  ConversorBTG
//
//  Created by Filipe Lopes on 21/11/20.
//

import Foundation

//Extensão da StartViewController para receber a ação delegada a ela, para receber a informação de quanto a requisição acabar
extension StartViewController: APIEnded{
    func reload(allCurrencies: [Currency]) {
        self.allCurrencies = allCurrencies
    }
}
