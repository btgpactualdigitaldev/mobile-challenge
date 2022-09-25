//
//  CoinViewModel.swift
//  CurrencyConverter
//
//  Created by Augusto Henrique de Almeida Silva on 07/10/20.
//

import Foundation

class CoinViewModel {
    let initials: String
    let name: String
    
    init(initials: String, name: String) {
        self.initials = initials
        self.name = name
    }
}
