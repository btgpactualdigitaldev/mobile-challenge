//
//  CurrencyListStrings.swift
//  mobile-challenge
//
//  Created by Caio Azevedo on 27/11/20.
//

import Foundation

enum CurrencyListStrings {
    case searchPlaceHolder
    case title
    
    var text: String {
        switch self {
        case .searchPlaceHolder:
            return "Buscar Moeda"
        case .title:
            return "Moedas"
        }
    }
}
