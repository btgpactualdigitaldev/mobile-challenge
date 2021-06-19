//
//  CommonData.swift
//  app-mobile-challenge
//
//  Created by Matheus Silva on 29/11/20.
//

import Foundation

// Class

final class CommonData {
    
    // Init

    private init() {}
    static let shared = CommonData()
    
    // Properties

    @UserDefaultAccess(key: "fromCurrency", defaultValue: "USD")
    public var fromCurrencyStorage: String

    @UserDefaultAccess(key: "toCurrency", defaultValue: "USD")
    public var toCurrencyStorage: String

    @UserDefaultAccess(key: "selectedTypeCurrency", defaultValue: "none")
    public var selectedTypeCurrency: String

    @UserDefaultAccess(key: "favorites", defaultValue: [])
    public var favorites: [String]

    @UserDefaultAccess(key: "lists", defaultValue: [])
    public var lists: Lists

    @UserDefaultAccess(key: "lives", defaultValue: [])
    public var lives: Lives
    
    @UserDefaultAccess(key: "lastUpdate", defaultValue: .zero)
    public var lastUpdate: Int
}
