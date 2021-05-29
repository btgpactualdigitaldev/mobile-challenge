//
//  ApiEndedProtocol.swift
//  ConversorBTG
//
//  Created by Filipe Lopes on 21/11/20.
//

import Foundation

///Protocolo para criação de um delegate para passar a referencia de todas as moedas entre Views
protocol APIEnded {
    func reload(allCurrencies: [Currency])
}
