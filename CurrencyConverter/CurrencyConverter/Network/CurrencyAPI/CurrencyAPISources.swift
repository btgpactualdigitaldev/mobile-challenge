//
//  CurrencyAPISources.swift
//  CurrencyConverter
//
//  Created by Isnard Silva on 02/12/20.
//

import Foundation

enum CurrencyAPISources {
    // MARK: - Base URL
    static let baseURL = "http://api.currencylayer.com"

    
    // MARK: - Extensions URL
    static let currencyValuesExtensionURL = "/live"
    static let currencyNamesExtensionURL = "/list"
    
    
    // MARK: API Key
    static let APIKey = "1bdc0cd2c1ce536b955c8b7e9dea6cc2"
    
    
    // MARK: - Parameter Name
    enum ParameterName {
        static let APIKey = "access_key"
    }
    
    enum ServiceType {
        case currencyValues
        case currencyNames
    }
}
