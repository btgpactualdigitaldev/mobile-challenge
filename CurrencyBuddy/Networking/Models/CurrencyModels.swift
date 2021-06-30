//
//  ViewController.swift
//  CurrencyBuddy
//
//  Created by Rodrigo Giglio on 21/12/20.
//

import Foundation

struct Currency {
    
    public static let defaultInputCurrencyCode = "BRL"
    public static let defaultOutputCurrencyCode = "USD"

    let code: String
    let name: String
    
    public static func fromDictionary(_ dict: [String: String]) -> [Currency] {

        var curencies: [Currency] = []
        for (code, name) in dict {
            curencies.append(Currency(code: code, name: name))
        }
        return curencies
    }
}

struct CurrencyValue {
    let code: String
    let value: Double /// The value is always related to USD
    
    public static func fromDictionary(_ dict: [String: Double]) -> [CurrencyValue] {

        var curencies: [CurrencyValue] = []
        for (code, value) in dict {
            curencies.append(CurrencyValue(code: code, value: value))
        }
        return curencies
    }
}

struct CurrencyResponse: Decodable {
    let currencies: [String:String]
}

struct CurrencyValueResponse: Decodable {
    let quotes: [String:Double]
}
