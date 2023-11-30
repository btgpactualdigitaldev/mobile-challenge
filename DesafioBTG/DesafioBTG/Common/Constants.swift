//
//  Constants.swift
//  DesafioBTG
//
//  Created by Admin Colaborador on 05/11/20.
//

import Foundation

class Constants {
    
    private static var apiKey: String = "1073608a9e4b609b397cb7fe15ece761"
    
    private static func baseURL(path: String) -> String {
        
        return "http://api.currencylayer.com/\(path)?access_key=\(apiKey)"
        
    }
    
    static let SupportedCurrenciesList = baseURL(path: "list")
    static let LiveCurrency = baseURL(path: "live")
    
    enum CurrencyType: String {
        
        case origin
        case target
    }
    
    
}
