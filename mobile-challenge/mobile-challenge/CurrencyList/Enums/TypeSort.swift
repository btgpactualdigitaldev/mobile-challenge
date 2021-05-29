//
//  TypeSort.swift
//  mobile-challenge
//
//  Created by Caio Azevedo on 28/11/20.
//

import Foundation

enum TypeSort {
    case code
    case name
    
    var title: String {
        switch self {
        case .code:
            return "Ordem: Código"
        case .name:
            return "Order: Nome"
        }
    }
}
