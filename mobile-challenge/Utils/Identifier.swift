//
//  Identifier.swift
//  mobile-challenge
//
//  Created by Murilo Teixeira on 26/09/20.
//

import Foundation

enum Identifier {
    
    enum Storyboard: String {
        case Main
    }
    
    enum Currency: String {
        case USD
    }
    
    enum CurrencyModel: String {
        case code, name, valorDollar
    }
    
    enum UserDefaultKey: String {
        case date
    }
}
