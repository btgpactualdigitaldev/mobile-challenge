//
//  PersistenceController.swift
//  BTGCurrencyConverter
//
//  Created by Ian McDonald on 22/07/20.
//  Copyright © 2020 Ian McDonald. All rights reserved.
//

import Foundation

enum PersistenceController {
    static private let defaults = UserDefaults.standard
    enum Keys {
        static let currencies = UserDefaultsKeys.currencies.rawValue
        static let quotes = UserDefaultsKeys.quotes.rawValue
    }
    
    static func updateCurrencies(_ currencies: Currencies) {
        do {
            let encoder = JSONEncoder()
            let encodedCurrencies = try encoder.encode(currencies)
            defaults.set(encodedCurrencies, forKey: Keys.currencies)
        } catch {
            // this is only internal so no need to show to the user. Log if a logging system is used
            print(BTGPersistenceError.unableToSaveCurrencies)
        }
    }
    
    static func updateQuotes(_ quotes: Quotes) {
        do {
            let encoder = JSONEncoder()
            let encodedQuotes = try encoder.encode(quotes)
            defaults.set(encodedQuotes, forKey: Keys.quotes)
        } catch {
            // this is only internal so no need to show to the user. Log if a logging system is used
            print(BTGPersistenceError.unableToSaveQuotes)
        }
    }
    
    static func retreiveCurrencies(completed: @escaping(Currencies?)->Void) {
        guard let currenciesData = defaults.object(forKey: Keys.currencies) as? Data else {
            completed(nil)
            return
        }
        
        do {
            let decoder = JSONDecoder()
            let currencies = try decoder.decode(Currencies.self, from: currenciesData)
            completed(currencies)
        } catch {
            completed(nil)
        }
    }
    
    static func retreiveQuotes(completed: @escaping(Quotes?)->Void) {
        guard let quotesData = defaults.object(forKey: Keys.quotes) as? Data else {
            completed(nil)
            return
        }
        
        do {
            let decoder = JSONDecoder()
            let quotes = try decoder.decode(Quotes.self, from: quotesData)
            completed(quotes)
        } catch {
            completed(nil)
        }
    }
}
