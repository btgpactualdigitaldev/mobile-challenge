//
//  SelectedCurrencySingleton.swift
//  Desafio-BTG
//
//  Created by Euclides Medeiros on 03/04/21.
//

import Foundation

struct SelectedCurrencySingleton {
    static var selectedCurrency: selectedCurrency?
    
}

enum selectedCurrency {
    case ofCurrency
    case toCurrency
}
