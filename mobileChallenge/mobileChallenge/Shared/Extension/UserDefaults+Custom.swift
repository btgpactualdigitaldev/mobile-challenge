//
//  UserDefaults+Custom.swift
//  mobileChallenge
//
//  Created by Renato Carvalhan on 05/12/20.
//  Copyright © 2020 Renato Carvalhan. All rights reserved.
//

import Foundation

extension UserDefaults {
    
    enum LCurrency {
        
        private static let baseCurrencyKey: String = "baseCurrency"
        static var baseCurrency: String {
           get {
            return UserDefaults.standard.codable(String.self, forKey: baseCurrencyKey) ?? "USD"
           }
           set(code) {
            UserDefaults.standard.set(encodable: code, forKey: baseCurrencyKey)
           }
        }
        
        private static let currenciesKey: String = "currencies"
        static var currencies: [Currency] {
           get {
            return UserDefaults.standard.codable([Currency].self, forKey: currenciesKey) ?? []
           }
           set(currency) {
            UserDefaults.standard.set(encodable: currency, forKey: currenciesKey)
           }
        }
        
        private static let favoritedCurrenciesKey: String = "favoritedCurrencies"
        static var favoritedCurrencies: [Live] {
           get {
            return UserDefaults.standard.codable([Live].self, forKey: favoritedCurrenciesKey) ?? []
           }
           set(live) {
            UserDefaults.standard.set(encodable: live, forKey: favoritedCurrenciesKey)
           }
        }
        
        private static let livesKey: String = "lives"
        static var lives: [Live] {
            get {
                return UserDefaults.standard.codable([Live].self, forKey: livesKey) ?? []
            }
            set(live) {
                UserDefaults.standard.set(encodable: live, forKey: livesKey)
            }
        }
    }
    
    private func set<T: Encodable>(encodable: T, forKey key: String) {
        let data = try? JSONEncoder().encode(encodable)
        UserDefaults.standard.setValue(data, forKey: key)
    }
    
    private func codable<T: Decodable>(_ type: T.Type, forKey key: String) -> T? {
        guard let data = UserDefaults.standard.value(forKey: key) else { return nil }
        let element = try? JSONDecoder().decode(T.self, from: data as! Data)
        return element
    }
}
