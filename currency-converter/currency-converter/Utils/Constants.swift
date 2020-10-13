//
//  Constants.swift
//  currency-converter
//
//  Created by Rodrigo Queiroz on 09/10/20.
//

import Foundation

class Constants {
    
    // https://api.currencylayer.com/
    private static var apiKey: String = "1073608a9e4b609b397cb7fe15ece761"
    
    private static func baseURL(path: String) -> String {
        
        return "http://api.currencylayer.com/\(path)?access_key=\(apiKey)"
        
    }
    
    static let ListCurrency = baseURL(path: "list")
    static let LiveCurrency = baseURL(path: "live")
    
    enum CurrencyType: String {
        case origin
        case target
    }
    
}
